# SmartPOS Ethiopia — Senior Code Review

A senior-level review of the SmartPOS Flutter client at `/Users/zelalem_12/Documents/workspace/smartpos/client`. Findings are prioritized by severity. No code was modified.

The passing `flutter analyze` / `flutter test` (332) / debug APK build confirm the project compiles and the existing unit/widget tests pass. They do **not** establish production, security, regulatory, or operational readiness. Several issues below are release-blocking regardless of those green checks.

---

## Critical — Release-blocking

### 1. Production network layer is entirely mocked
- `lib/core/network/api_client.dart:22-23` unconditionally adds `MockInterceptor()` to Dio in **all** builds.
- `lib/core/network/mock_interceptor.dart:20-36` accepts only the hard-coded `AppConstants.mockLicenseKey = 'MOR-4A9K2L8Q'` and returns a 401 for anything else.
- The mock activation response ships hard-coded TIN/VAT/business PII (`mock_interceptor.dart:73-81`).
- All sync endpoints (`syncInvoices`, `sync`, `usersSync`) are no-ops returning `{'status': 'synced'}` with no signature, nonce, or server round-trip.
- Unknown paths fall through to `baseUrl = https://api.smartpos.et/v1` (likely non-existent), risking crashes or request leakage.
- No certificate pinning.

**Impact:** The app cannot activate, sync, or authenticate against a real backend. Any user can activate with a public hard-coded key. **This alone blocks any production release.**

**Fix:** Gate `MockInterceptor` behind `kDebugMode`/build flavors; implement a real activation/sync API with signed responses and certificate pinning; remove `mockLicenseKey` and fake business data from release binaries.

### 2. SQLite database is unencrypted
- `lib/core/database/app_database.dart:31-35` and `lib/core/di/injection.dart:452` open a plain `NativeDatabase` file in app documents.
- All fiscal records, password hashes/salts, TIN/VAT, invoices, and audit logs sit in a readable `.db` file.

**Impact:** Root access or a stolen/unlocked device exposes the entire fiscal dataset and credential material. For a POS handling Ethiopian e-invoicing data this is unacceptable.

**Fix:** Wire SQLCipher / `sqlite3mc` with a key derived from the Android Keystore / iOS Keychain; enable `PRAGMA secure_delete`; never store the DB on shared/external storage.

### 3. Fiscal money is stored and computed as `double` / SQLite `REAL`
Pervasive across entities, tables, DAOs, repositories, and UI (full file list in subagent report; e.g. `cart_entity.dart:26-33`, `vat_calculator.dart:21-45`, `transaction_dao.dart:217-223,403-432`, all `*_table.dart` money columns).

**Impact:** Floating-point drift makes line-item sums diverge from header totals, Z-reports unreconcilable, and hash-chain payloads non-deterministic across devices. This is a fiscal-compliance risk, not just a numeric one.

**Fix:** Migrate to integer cents (`IntColumn`) end-to-end; round each line to cents, then sum for the header; guarantee `gross = net + vat` per row; recompute VAT in cents with half-up rounding.

### 4. VAT rounding model is inconsistent
- `invoice_repository_impl.dart:82-83` computes per-line net via `VatCalculator.grossToNet(gross)` and `vat = gross - net`, rounding each line.
- The invoice header uses `cart.totals` (`cart_entity.dart:30-33`), which recomputes net/VAT on the **entire** gross and rounds independently.
- `vatTotal = grossTotal - netTotal` is unrounded.

**Impact:** `Σ line.netAmount` may not equal `invoice.netTotal`; same for VAT. This will fail Ethiopian Tax Authority reconciliation.

**Fix:** Compute and round per line in cents, then sum for the header. Round `vatTotal` explicitly.

### 5. Audit hash chain is not tamper-resistant
- `lib/core/utils/hash_chain.dart:23-28` uses unkeyed `SHA-256(prevHash + json)` — anyone with DB write access can recompute a valid chain.
- Chain head and records live in the same SQLite file the chain is supposed to protect.
- `verifyHash` (line 40) uses `==`, not constant-time comparison.
- Z-report sync/audit entries are anchored to an arbitrary `dayInvoices.first.id` (`transaction_dao.dart:508-519`) because `sync_queue.invoiceId` is `NOT NULL` (`sync_queue_table.dart:14`).

**Impact:** The audit trail cannot satisfy regulatory or forensic requirements. An attacker who reaches the DB file can rewrite history consistently.

**Fix:** Use HMAC-SHA256 with a device- or server-bound key; anchor the latest chain head outside the DB (Keystore HMAC or server countersign); constant-time verify; make `sync_queue.invoiceId` nullable with `ref_type`/`ref_id` (already noted in `AGENTS.md`).

---

## High — Fix before production

### 6. No brute-force protection on local login
`auth_repository_impl.dart:110-132` runs full PBKDF2 verification on every attempt with no counter, lockout, backoff, or audit. POS terminals are often unattended.

**Fix:** Per-username failed-attempt counter with exponential backoff/lockout; audit login success/failure/lockout.

### 7. PBKDF2 configuration and implementation
`lib/core/utils/password_hasher.dart`:
- `defaultIterations = 100000` (line 47) — OWASP 2023 recommends ≥600,000 for PBKDF2-HMAC-SHA256.
- Hand-rolled PBKDF2 (lines 101-135) instead of a vetted library (`pointycastle`).
- `_constantTimeEquals` (line 175) early-returns on length mismatch and compares hex `String` code units, not raw bytes.
- No password-strength enforcement at the hasher or repository (`auth_repository_impl.dart:82`).

**Fix:** Use `pointycastle`'s audited PBKDF2; raise iterations to ≥600,000 (or tune to target hardware); compare raw `Uint8List`; remove the length early-return; enforce minimum length/PIN policy in the use case.

### 8. Session has no timeout or hardening
`lib/core/services/session_service.dart`:
- No idle/absolute timeout — once `setUser` is called the session is valid forever until `clear()` (`:74-83`).
- `setUser` does not validate the role string (`:74-77`).
- `seedStartupState` (`:99-105`) is `@visibleForTesting` but ships in release.
- Unknown role falls through to `homeRoute = null` (`:110-113`), and combined with `evaluateRedirect` Guard 7 (`:191-193`) this can produce a **self-redirect loop** at `/login` for any user with an unrecognized role.

**Fix:** Add inactivity + max-lifetime timers; validate role on `setUser`; guard `seedStartupState` with `!kReleaseMode`; make Guard 7 exclude public paths or return an explicit safe fallback for unknown roles.

### 9. Business rules live inside `TransactionDao`
`lib/core/database/daos/transaction_dao.dart` contains cancellation-reason whitelists (`:300-307`), 48-hour window (`:319-321`), duplicate-request checks (`:322-327`), credit-note validation (`:167-174`), Z-report rules (`:434-456`), invoice numbering, and hash-chain computation (`:50-149`). The file itself admits this (`:24-28`).

**Impact:** Domain rules are untestable without a database, duplicated in spirit across repository mappers, and invisible to the domain layer. This is the largest clean-architecture violation.

**Fix:** Move validation, numbering, and hashing into domain use cases/services; `TransactionDao` should only execute pre-built companions atomically.

### 10. `AppDatabase` delegating accessors are a facade, not a DAO extraction
`app_database.dart:190-296` exposes ~40 one-line forwarders, but `injection.dart:102` only registers `AppDatabase` — the DAOs are not injectable, so callers cannot "depend on the DAOs directly" as the comment suggests. `AppDatabase` remains a data-layer god object.

**Fix:** Register DAOs in DI; have repositories depend on DAOs; remove the forwarders (and the static `toDeterministicJson` shim) once callers migrate.

### 11. `UserRepository` leaks Drift into the domain
`lib/core/repositories/user_repository.dart:1` imports `app_database.dart` and exposes `User` (Drift model) and `UsersCompanion` in the contract. `SessionService` and `CashierManagementCubit` are forced to know Drift.

**Fix:** Introduce `UserEntity` + mapper; move the abstraction under `features/auth/domain/`; never expose `UsersCompanion` past the repository implementation.

### 12. N+1 query in X-report
`transaction_dao.dart:403-413` issues a separate `select(payments)` per invoice. On a busy day this blocks the UI.

**Fix:** Join `invoices` and `payments` once, or fetch all payments for the day in a single query and group in Dart.

### 13. Repository robustness gaps in invoice creation
`invoice_repository_impl.dart`:
- `payment!` (line 61) is a runtime null-assert that will crash if the transaction didn't create a payment row.
- `paymentReference` is hard-coded to `''` for non-cash payments (line 40) — telebirr/CBE Birr invoices can be created with empty provider references.
- `buyerTin` is only validated in the UI.

**Fix:** Replace `payment!` with an explicit null check → `NotFoundFailure`; require non-empty `paymentReference` for non-cash; validate `buyerTin` in the domain use case.

---

## Medium — Address before scale

### 14. Cart is a singleton shared across sessions
`cart_repository_impl.dart:9-10` holds `_cart` in a field; `injection.dart:245` registers it as `registerLazySingleton`. `CartBloc` is a factory but reuses the same repository, so the cart is **not** reset per session/checkout unless `clear()` is explicitly called.

**Fix:** Reset the cart on checkout completion and on logout, or register the repository as a factory scoped to the POS flow.

### 15. `SyncQueueCubit` bypasses `NetworkInfo`
`sync_queue_cubit.dart:3-4,16-34` depends on the concrete `Connectivity` plugin and re-implements the `results.any((r) != none)` check that `NetworkInfo` already abstracts. This couples the presentation layer to a third-party package and makes the cubit hard to test.

**Fix:** Inject `NetworkInfo` (or the existing `WatchSyncConnectivity` use case) and consume `Stream<bool>`.

### 16. `NetworkInfo` "online" is naïve
`network_info.dart:34-36` treats any non-`none` result (incl. captive Wi-Fi, bluetooth, vpn) as online with no reachability probe.

**Fix:** Add a lightweight HEAD/DNS probe to the backend; treat bluetooth/vpn cautiously; consider `isUnmetered` for large syncs.

### 17. `CatalogBloc` masks errors and double-loads
`catalog_bloc.dart:99-163` emits `CatalogError(...)` then immediately re-emits `currentState` if it was `CatalogLoaded`, so the user never sees the error. Mutations emit `CatalogLoading` then dispatch `LoadCatalog`, which emits `CatalogLoading` again.

**Fix:** Don't re-emit `currentState` after `CatalogError`; let the UI react. Avoid the double loading emission.

### 18. `sl<...>()` called inside the router
`app_router.dart` reaches into the service locator at ~13 call sites to build BLoCs/Cubits per route. This is view-layer DI coupling.

**Fix:** Construct the `GoRouter` via DI, or provide BLoCs at the app root with `MultiBlocProvider` and use `BlocProvider.value` per route.

### 19. Legacy SHA-256 credentials persist indefinitely
`auth_repository_impl.dart:127-129` upgrades legacy hashes only on a successful login. Users who never log in again remain on weak unsalted SHA-256.

**Fix:** Force a password reset after a configured grace period; track migration status per user.

### 20. `usernameExists` enables enumeration
`auth_repository_impl.dart:33-34` exposes `usernameExists` publicly, undermining the generic login error message.

**Fix:** Remove from the public repository interface or gate it behind manager authorization.

### 21. No audit events for authentication
The auth repository writes no `AuditLog` entries for login success/failure, lockout, or password change. Insider abuse and credential stuffing are undetectable.

**Fix:** Write security-relevant audit events from the auth use case/repository.

---

## Lower — Cleanup and maintainability

### 22. Dead/unused code
- `lib/core/theme/app_text_styles.dart` — never imported.
- `lib/shared/extensions/string_extensions.dart` — only self-referencing matches.
- `AppConstants.duplicateWatermark` — defined but unused; `receipt_widget.dart:65` inlines the same string.
- `MockPrinterService` is registered for non-Android platforms in production (`injection.dart:116-119`) — test fake shipped in release.
- `integration_test` SDK is declared but no `integration_test/` directory exists; `pos_catalog_integration_test.dart` is a widget test, not an integration test.

**Fix:** Delete unused files; gate `MockPrinterService` behind `kDebugMode`; either add real integration tests or drop the `integration_test` dependency.

### 23. Thin, valueless data-source wrappers
`auth_local_source.dart` and `activation_local_source.dart` are pure forwarders whose only added behavior is `CacheFailure` mapping that should live in the repository. They add boilerplate without abstraction.

**Fix:** Collapse into the repository (or a mapper) and delete the wrapper.

### 24. Hard-coded string constants scattered
`MANAGER`, `CASHIER`, `PENDING`, `PENDING_SYNC`, `SYNCED`, `FAILED`, `PROCESSING`, payment methods (`cash`, `telebirr`, `cbeBirr`), and cancellation reasons are repeated as raw strings across DAOs, tables, repositories, and UI (full table in subagent report).

**Fix:** Centralize in `app_constants.dart` or derive from enums (`PaymentMethod`, `UserRole`, `SyncStatus`).

### 25. `CacheFailure` misused for printer errors
`receipt_printer.dart:25` and `sunmi_printer_service.dart` (many lines) throw `CacheFailure` for printer failures. `NetworkFailure` is defined but never used. `PosBloc`/`CatalogBloc` surface `'Unexpected error: $e'` to the UI.

**Fix:** Add a `PrinterFailure`; use `NetworkFailure` in network sources; map generic exceptions to `Failure` subtypes before reaching the UI.

### 26. Toolchain maintenance debt
Debug build warnings: Gradle 8.14.2 (Flutter recommends ≥9.1.0), AGP 8.11.1 (recommends ≥9.0.1), Kotlin 2.2.20 (recommends ≥2.3.20). Not immediate failures, but each is approaching the support cliff.

**Fix:** Schedule a toolchain bump before the next Flutter stable forces it.

### 27. Large hand-written files
`transaction_dao.dart` (556), `pos_page.dart` (489), `injection.dart` (452), `manager_setup_page.dart` (365), `sync_queue_page.dart` (326), `audit_page.dart` (315). `app_database.g.dart` (15,319) is generated and expected. The hand-written large files mostly reflect the business-rule leakage and UI bloat noted above; splitting them follows naturally from fixing items 9, 14, and 18.

---

## Verdict

The codebase is well-structured at the folder level, uses `flutter_bloc` consistently, and passes its own tests. However, it is **not production-ready**. The five Critical items (mocked network, unencrypted DB, `double` money, VAT rounding, non-tamper-resistant audit chain) are each individually release-blocking for a fiscal POS, and several High items (no brute-force protection, business rules in the DAO, session without timeout, `UserRepository` leaking Drift) would block a serious production review even if the Criticals were fixed.

### Recommended order of work
1. Replace the mock network layer with a real, pinned, signed backend (Critical 1).
2. Encrypt the database with a hardware-backed key (Critical 2).
3. Migrate money to integer cents and fix VAT rounding (Critical 3, 4).
4. Harden the audit chain with an external anchor and HMAC (Critical 5).
5. Add brute-force protection, raise PBKDF2 iterations, and use a vetted KDF (High 6, 7).
6. Add session timeout and fix the unknown-role redirect loop (High 8).
7. Move business rules out of `TransactionDao` and register DAOs in DI (High 9, 10, 11).
8. Fix the X-report N+1 and invoice-creation robustness gaps (High 12, 13).
9. Then address the Medium and Lower items in priority order.

---

*No code was changed during this review.*
