import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/users_table.dart';

part 'users_dao.g.dart';

/// Data access for the users table.
///
/// Persistence-only: password hashing and business validation live in the
/// auth repository / use cases, not here.
@DriftAccessor(tables: [Users])
class UsersDao extends DatabaseAccessor<AppDatabase> with _$UsersDaoMixin {
  UsersDao(super.db);

  Future<List<User>> getActiveUsers() {
    return (select(users)..where((u) => u.isActive.equals(true))).get();
  }

  Future<List<User>> getAllUsers() {
    return (select(
      users,
    )..orderBy([(u) => OrderingTerm.asc(u.fullName)])).get();
  }

  Future<User?> getUserById(String id) {
    return (select(users)..where((u) => u.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertUser(UsersCompanion user) => into(users).insert(user);

  Future<bool> updateUser(UsersCompanion user) =>
      (update(users)..where((u) => u.id.equals(user.id.value)))
          .write(user)
          .then((rows) => rows > 0);

  Future<bool> hasManager() async {
    final count = await (select(
      users,
    )..where((u) => u.role.equals('MANAGER') & u.isActive.equals(true))).get();
    return count.isNotEmpty;
  }

  Future<User?> findUserByUsername(String username) {
    return (select(users)
          ..where((u) => u.username.equals(username) & u.isActive.equals(true)))
        .getSingleOrNull();
  }
}
