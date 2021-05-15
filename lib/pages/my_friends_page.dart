import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/friends_page/friend_page_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/handlers/alert_exception.dart';
import 'package:my_life/models/other_user/other_user.dart';

class MyFriendsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FriendPageCubit>(
      create: (BuildContext context) => FriendPageCubit(context: context, user: BlocProvider.of<UserCubit>(context).user),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Friends'),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'search user',
                      hintStyle: TextStyle(fontSize: 20.0),
                      icon: Icon(Icons.search)
                  ),
                ),
              ),
              BlocBuilder<FriendPageCubit, FriendPageState>(
                builder: (BuildContext context, FriendPageState state) {
                  if (state is FriendPageInitialised || state is FriendPageOperation) {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 5, 10),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Possible friends:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: BlocProvider.of<FriendPageCubit>(context).allUsers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OtherUserAllUsers(user: BlocProvider.of<FriendPageCubit>(context).allUsers[index]);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 5, 10),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('My friends:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: BlocProvider.of<FriendPageCubit>(context).myFriends.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OtherUserMyFriends(user: BlocProvider.of<FriendPageCubit>(context).myFriends[index]);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 5, 10),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Invitations to friends:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: BlocProvider.of<FriendPageCubit>(context).mySendInvites.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OtherUserMySendInvites(user: BlocProvider.of<FriendPageCubit>(context).mySendInvites[index]);
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 20, 5, 10),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('My invitations:', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: BlocProvider.of<FriendPageCubit>(context).getMyReceiveFriend.length,
                              itemBuilder: (BuildContext context, int index) {
                                return OtherUserMyReceiveFriend(user: BlocProvider.of<FriendPageCubit>(context).getMyReceiveFriend[index]);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is FriendPageServerFuckUp) {
                    return Center(
                      child: Text('Sorry!\n\n.Net Server is wracked! (500)'),
                    );
                  }
                  if (state is FriendPageServerShutdown) {
                    return Center(
                      child: Text('Sorry!\n\n.Net Server is unavailable!'),
                    );
                  }
                  if (state is FriendPageSomethingInvalid) {
                    Future.microtask(() => AlertException.showAlertDialog(context, state.errorText)).then((value)
                    {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed("/home");
                    });
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          )
      )
    );
  }
}