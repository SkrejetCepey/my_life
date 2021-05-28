part of 'goals_list_cubit.dart';

@immutable
abstract class GoalsListState {}

class GoalsListInitial extends GoalsListState {}
class GoalsListInitialEmpty extends GoalsListState {}
class GoalsListInitialised extends GoalsListState {}
class GoalsListAddItem extends GoalsListState {}
