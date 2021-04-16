import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/models/user/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {

  User user;

  UserCubit() : super(UserInitial()) {
    _initUser();
  }

  Future<void> _initUser() async {

    if ((await UserHiveRepository.db.getAll()).isEmpty) {
      emit(UserInitEmpty());
    } else {
      this.user = (await UserHiveRepository.db.getAll()).last;
      emit(UserInit());
    }

  }

  Future<void> addUser(User user) async {

    await UserHiveRepository.db.create(user);
    emit(UserCreate());
    await _initUser();
  }

  Future<void> deleteUser() async {

    await UserHiveRepository.db.delete(this.user);
    emit(UserDelete());
    await _initUser();

  }

}

