part of 'friend_page_cubit.dart';

@immutable
abstract class FriendPageState {}

@immutable
mixin FriendPageOperation{}

class FriendPageInitial extends FriendPageState {}

class FriendPageEmpty extends FriendPageState {}

class FriendPageInitialised extends FriendPageState {}

class FriendPageRefreshingTokens extends FriendPageState {}

class FriendPageAddingNewFriend extends FriendPageState with FriendPageOperation {}

class FriendPageRemovingSentRequest extends FriendPageState with FriendPageOperation {}

class FriendPageRemovingFriend extends FriendPageState with FriendPageOperation {}

class FriendPageServerShutdown extends FriendPageState {}

class FriendPageServerFuckUp extends FriendPageState {}

class FriendPageApplyFriendRequest extends FriendPageState with FriendPageOperation {}

class FriendPageRemoveFriendInvitation extends FriendPageState with FriendPageOperation {}

class FriendPageSomethingInvalid extends FriendPageState {
  final String errorText;

  FriendPageSomethingInvalid(this.errorText);
}
