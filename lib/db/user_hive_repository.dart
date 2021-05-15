import 'package:my_life/models/user/user.dart';
import 'hive_db_implementation_mixin.dart';

class UserHiveRepository with HiveDBImplementationMixin<User> {

  UserHiveRepository._() {
    databaseName = 'user';
  }
  static final UserHiveRepository db = UserHiveRepository._();

  // Future<void> createIfNotExist(User entry) async {
  //   return ((await database).values.where((User user) => user.login == entry.login).isEmpty) ? await create(entry) : null;
  // }
}