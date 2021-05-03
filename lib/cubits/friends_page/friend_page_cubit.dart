import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/errors/my_life_error.dart';
import 'package:my_life/handlers/alert_exception.dart';
import 'package:my_life/models/user/user.dart';
import 'package:my_life/networking/connection.dart';

part 'friend_page_state.dart';

class FriendPageCubit extends Cubit<FriendPageState> {

  BuildContext context;
  final User user;
  List<User> allUsers = <User>[];
  List<User> myFriends = <User>[];
  List<User> mySendInvites = <User>[];
  List<User> getMyReceiveFriend = <User>[];

  FriendPageCubit({@required this.context, @required this.user}) : super(FriendPageInitial()) {
    _init();
  }

  Future<void> _init() async {

    try {

      // safe init transaction
      await Future.wait([Connection.getAllUsers(BlocProvider.of<UserCubit>(context).user, context),
        Connection.getMyFriends(BlocProvider.of<UserCubit>(context).user),
        Connection.getSendInvites(BlocProvider.of<UserCubit>(context).user),
        Connection.getReceiveFriendList(BlocProvider.of<UserCubit>(context).user)
      ]).then((value)  {
        allUsers = value[0];
        myFriends = value[1];
        mySendInvites = value[2];
        getMyReceiveFriend = value[3];
        emit(FriendPageInitialised());
      }, onError: (e) => throw e);

    } on MLNetworkError catch(e) {
      if (e.response.statusCode == 401) {
        await _refresh();
      } else if (e.response.statusCode == 404) {
        emit(FriendPageServerShutdown());
      } else {
        print('CubitFriendPageError: $e');
      }
    }

  }

  Future<void> _refresh() async {

    emit(FriendPageRefreshingTokens());
    try {
      Map<String, dynamic> tokens = await Connection.refreshTokens(user);
      BlocProvider.of<UserCubit>(context).user.refreshToken = tokens['refreshToken'];
      BlocProvider.of<UserCubit>(context).user.accessToken = tokens['accessToken'];
      await BlocProvider.of<UserCubit>(context).updateUser();
      await _init();
    } on MLNetworkError catch(e) {
      emit(FriendPageSomethingInvalid('${e.response.statusCode}\n${e.response.statusMessage}'));
    }

  }

  Future<void> _errorHandler(MLNetworkError e) async {

    if (e.response.statusCode == 401) {
      try {
        print('trying to get new tokens...');
        await _refresh();
      } on Exception catch(e) {
        Future.microtask(() => AlertException.showAlertDialog(context, e.toString())).then((value)
        {
          Future.wait([BlocProvider.of<UserCubit>(context).deleteUser()]).then((value) => Navigator.of(context).pop());
        });
      }
    } else {
      Future.microtask(() => AlertException.showAlertDialog(context, '${e.response.statusCode}\n${e.response.statusMessage}\n${e.response.data['errorMessage']}'))
          .then((value) => emit(FriendPageInitialised()));
    }

  }

  Future<void> removeSentRequest(String userId) async {
    emit(FriendPageRemovingSentRequest());

    try {
      await Connection.removeSentRequest(BlocProvider.of<UserCubit>(context).user, userId);
      mySendInvites.removeWhere((element) => element.id == userId);
      emit(FriendPageInitialised());
    } on MLNetworkError catch(e) {
      await _errorHandler(e);
    }
  }

  Future<void> removeFriend(String userId) async {
    emit(FriendPageRemovingFriend());

    try {
      await Connection.removeFriend(BlocProvider.of<UserCubit>(context).user, userId);
      allUsers.addAll(myFriends.where((element) => element.id == userId));
      myFriends.removeWhere((element) => element.id == userId);
      emit(FriendPageInitialised());
    } on MLNetworkError catch(e) {
      await _errorHandler(e);
    }
  }

  Future<void> sentFriendRequest(String userId) async {
    emit(FriendPageAddingNewFriend());

    try {
      await Connection.sentFriendRequest(BlocProvider.of<UserCubit>(context).user, userId);
      mySendInvites.addAll(allUsers.where((element) => element.id == userId));
      emit(FriendPageInitialised());
    } on MLNetworkError catch(e) {
      await _errorHandler(e);
    }
  }

  Future<void> applyFriendRequest(String userId) async {
    emit(FriendPageApplyFriendRequest());

    try {
      await Connection.applyFriendRequest(BlocProvider.of<UserCubit>(context).user, userId);
      myFriends.addAll(getMyReceiveFriend.where((element) => element.id == userId));
      getMyReceiveFriend.removeWhere((element) => element.id == userId);
      emit(FriendPageInitialised());
    } on MLNetworkError catch (e) {
      await _errorHandler(e);
    }
  }

  Future<void> removeFriendInvitation(String userId) async {
    emit(FriendPageRemoveFriendInvitation());

    try {
      await Connection.removeFriendInvitation(BlocProvider.of<UserCubit>(context).user, userId);
      getMyReceiveFriend.removeWhere((element) => element.id == userId);
      emit(FriendPageInitialised());
    } on MLNetworkError catch (e) {
      await _errorHandler(e);
    }
  }

}
