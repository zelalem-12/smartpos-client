# SmartPOS Ethiopia — Client

## Verification commands

- **Format:** `dart format .`
- **Analyze:** `flutter analyze`
- **Tests:** `flutter test`
- **Android debug build:** `flutter build apk --debug`
- **Drift codegen:** `dart run build_runner build` (run after editing any `*_table.dart` or `@DriftDatabase`)

Use the absolute Flutter path on this machine:

```
/Users/zelalem_12/development/flutter/bin/flutter
```

## Architecture

Feature-first clean architecture under `lib/`:

- `core/` — database, DI, network, router, services, theme, utils
- `features/<feature>/` — `data/` (datasources, models, repositories), `domain/` (entities, repositories, usecases), `presentation/` (bloc/cubit, pages, widgets)
- `shared/` — cross-feature widgets, extensions, navigation helpers

State management: `flutter_bloc`. DI: `get_it`. Navigation: `go_router`. ORM: Drift + SQLite.

## Database schema versions

| Version | Scope |
|---------|-------|
| 1 | store config, users |
| 2 | categories, products |
| 3 | invoices, invoice items, payments, sync queue, audit logs |
| 4 | credit notes, cancellations, daily reports |
| 5 | sync queue lifecycle fields, audit payload |
| 6 | per-user password salt + PBKDF2 iteration count |

Migrations are additive and self-repairing: `beforeOpen` re-adds any missing
columns for partially migrated databases (see `_ensurePhase10Columns` and
`_ensurePasswordColumns` in `lib/core/database/app_database.dart`).

## Deferred security work (tracked, not yet implemented)

These items are known gaps. They are intentionally deferred to focused
follow-up work; do not assume they are done.

1. **Database encryption.** The production SQLite file is **not** encrypted.
   `driftDatabase(name: 'smartpos')` opens a plain `NativeDatabase`. Wire up
   sqlite3mc / SQLCipher with a device-bound key (Android Keystore / iOS
   Keychain) before storing the DB on shared/external storage.
2. **Audit chain tamper-resistant anchor.** The SHA-256 hash chain is stored
   in the same database it verifies, so an attacker with file-system write
   access can rewrite the whole chain consistently. Persist the chain head
   (latest hash + count) in a tamper-resistant location (Keystore-backed
   HMAC, or server countersign on each sync).
3. **Integer-cents money.** Monetary values are stored as `double` across
   tables, entities, and UI. Migrate to integer cents to eliminate
   floating-point rounding drift in fiscal records.
4. **Generic sync reference.** `sync_queue.invoice_id` is `NOT NULL` and
   FK-references `invoices`, so non-invoice sync rows (e.g. Z-report) point
   at an arbitrary invoice. Make it nullable and add `ref_type`/`ref_id`.

## Password hashing

Credentials use PBKDF2-HMAC-SHA256 (NIST SP 800-132) with a per-user random
salt and a persisted iteration count (default 100,000). See
`lib/core/utils/password_hasher.dart`.

Legacy rows created before schema v6 hold an unsalted SHA-256 digest with
`password_salt = NULL` and `password_iterations = NULL`. On the next
successful login they are transparently re-hashed with PBKDF2 — no forced
password reset is required.
