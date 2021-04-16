part of 'desires_list_cubit.dart';

@immutable
abstract class DesiresListState {}

class DesiresListInitial extends DesiresListState {}

class DesiresListInitialised extends DesiresListState {}

class DesiresListInitialisedEmpty extends DesiresListState {}

class DesiresListAddedNewItem extends DesiresListState {}

class DesiresListRefresh extends DesiresListState {}

class DesiresListUpdatedItem extends DesiresListState {}

class DesiresListDeletedItem extends DesiresListState {}

class DesiresListDeleteUser extends DesiresListState {}

class DesiresListCreateUser extends DesiresListState {}

class DesiresListInitUser extends DesiresListState {}

class DesiresListUpdateUser extends DesiresListState {}