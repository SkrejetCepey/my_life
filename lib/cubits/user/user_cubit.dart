import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/errors/my_life_error.dart';
import 'package:my_life/models/user/user.dart';
import 'package:my_life/networking/connection.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {

  User user;

  UserCubit() : super(UserInitial()) {
    _initUser();
  }

  Future<void> _initUser() async {

    // await Future.wait([UserHiveRepository.db.getAll()]).then((value) {
    //
    //   if (value[0].isNotEmpty) {
    //     print("value[0].last.login: ${value[0].last.login}");
    //     print("value[0].last.isInBox: ${value[0]?.last?.isInBox}");
    //   } else {
    //     print("value[0].isNotEmpty: ${value[0].isNotEmpty}");
    //   }
    //
    //   if (value[0].isNotEmpty && value[0].last.login != null && value[0].last.isInBox) {
    //     this.user = value[0].last;
    //     emit(UserInit());
    //   } else {
    //     emit(UserInitEmpty());
    //   }
    // });
    emit(UserInit());

  }

  Future<void> selectUser(User user) async {
    this.user = user;
    emit(UserSelect());
    await _initUser();
  }

  Future<void> addSingletonUser(User user, BuildContext context) async {
    print("addSingleton: ${user.login}");
    for (User val in (await UserHiveRepository.db.database).values) {
      if (val.login == user.login) {
        print("User found!");
        // await UserHiveRepository.db.create(user);
        BlocProvider.of<DesiresListCubit>(context).updateUser(val);
        this.user = val;
        return;
        // this.user = (await UserHiveRepository.db.database).get(user.key);
      }
    }
    print("User not found!");

    await UserHiveRepository.db.create(user);
    BlocProvider.of<DesiresListCubit>(context).updateUser((await UserHiveRepository.db.database).get(user.key));

    emit(UserCreateSingleton());
    await _initUser();
  }

  Future<void> addUser(User user) async {

    await UserHiveRepository.db.create(user);
    this.user = (await UserHiveRepository.db.database).get(user.key);
    emit(UserCreateSingleton());
    await _initUser();
  }

  Future<void> deleteUser() async {

    await UserHiveRepository.db.delete(this.user);
    emit(UserDelete());
    await _initUser();

  }

  Future<void> updateTokens() async {

    try {
      Map<String, dynamic> tokens = await Connection.refreshTokens(user);
      user.refreshToken = tokens['refreshToken'];
      user.accessToken = tokens['accessToken'];
      await updateUser();
    } on MLNetworkError catch(e) {
      if (e.response.statusCode == 400) {
        throw e;
      }
      throw e;
    }

  }

  Future<void> updateUser() async {

    emit(UserUpdate());
    if (user.isInBox) {
      await UserHiveRepository.db.update(user);
    }
    await _initUser();

  }

}

