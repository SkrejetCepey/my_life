part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserInit extends UserState {}

class UserCreate extends UserState {}

class UserDelete extends UserState {}

class UserInitEmpty extends UserState {}

class UserUpdate extends UserState {}

class UserSelect extends UserState {}
