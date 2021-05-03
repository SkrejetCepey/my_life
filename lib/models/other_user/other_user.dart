import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/friends_page/friend_page_cubit.dart';
import 'package:my_life/cubits/other_user/other_user_cubit.dart';
import 'package:my_life/models/user/user.dart';
import 'package:my_life/pages/other_user_page.dart';

abstract class OtherUser extends StatelessWidget {

  final User user;

  const OtherUser({this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtherUserCubit(friendPageCubit: BlocProvider.of<FriendPageCubit>(context)),
      child: BlocBuilder<OtherUserCubit, OtherUserState>(
        builder: (BuildContext context, OtherUserState state) {
          return ListTile(
            title: Row(
              children: [
                Icon(Icons.person, size: 50.0),
                SizedBox(
                  width: 25.0,
                ),
                Text('${user.username}', style: TextStyle(fontSize: 20.0)),
                Spacer(),
                Builder(
                  builder: (BuildContext context) {
                    if (state is OtherUserNetworkAction) {
                      return CircularProgressIndicator();
                    } else {
                      return callbackItemButton(context);
                    }
                  },
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => OtherUserPage(user)));
            },
          );
        },
      ),
    );
  }

  Widget callbackItemButton(BuildContext context) {
    throw UnimplementedError('callbackItemButton not implemented!');
  }

}

class OtherUserAllUsers extends OtherUser {

  OtherUserAllUsers({@required user}) : super(user: user);

  @override
  Widget callbackItemButton(BuildContext context) {
    return IconButton(icon: Icon(Icons.add_circle_outline_sharp, size: 30.0), onPressed: () {
      BlocProvider.of<OtherUserCubit>(context).sentFriendRequest(user.id);
    });
  }

}

class OtherUserMyFriends extends OtherUser {

  OtherUserMyFriends({@required user}) : super(user: user);

  @override
  Widget callbackItemButton(BuildContext context) {
    return IconButton(icon: Icon(Icons.remove_circle_outline, size: 30.0), onPressed: () {
      BlocProvider.of<OtherUserCubit>(context).removeFriend(user.id);
    });
  }

}

class OtherUserMySendInvites extends OtherUser {

  OtherUserMySendInvites({@required user}) : super(user: user);

  @override
  Widget callbackItemButton(BuildContext context) {
    return IconButton(icon: Icon(Icons.remove_circle_outline, size: 30.0), onPressed: () {
      BlocProvider.of<OtherUserCubit>(context).removeSentRequest(user.id);
    });
  }

}

class OtherUserMyReceiveFriend extends OtherUser {

  OtherUserMyReceiveFriend({@required user}) : super(user: user);

  @override
  Widget callbackItemButton(BuildContext context) {
    return Row(
      children: [
        IconButton(icon: Icon(Icons.remove_circle_outline, size: 30.0), onPressed: () {
          BlocProvider.of<OtherUserCubit>(context).removeFriendInvitation(user.id);
        }),
        IconButton(icon: Icon(Icons.add_circle_outline_sharp, size: 30.0), onPressed: () {
          BlocProvider.of<OtherUserCubit>(context).applyFriendRequest(user.id);
        })
      ],
    );
  }

}