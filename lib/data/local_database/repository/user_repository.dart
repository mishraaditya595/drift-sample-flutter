import 'package:drift/drift.dart';
import 'package:drift_new/data/local_database/entities/user_entity.dart';

import '../app_database.dart';

part 'user_repository.g.dart';

@DriftAccessor(tables: [User])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(AppDatabase db) : super(db);

  Future<List<UserData>> getAllUsers() => select(db.user).get();

  Future<UserData?> getUser(int id) => (select(db.user)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertUser(Insertable<UserData> user) => into(db.user).insert(user);

  Future updateUser(Insertable<UserData> user) => update(db.user).replace(user);

  Future deleteUser(Insertable<UserData> user) => delete(db.user).delete(user);
}