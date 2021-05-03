import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/cubits/friends_page/friend_page_cubit.dart';

part 'other_user_state.dart';

class OtherUserCubit extends Cubit<OtherUserState> {

  final FriendPageCubit friendPageCubit;

  OtherUserCubit({@required this.friendPageCubit}) : super(OtherUserInitial());

  Future<void> sentFriendRequest(String userId) async {
    emit(OtherUserNetworkAction());
    await friendPageCubit.sentFriendRequest(userId);
    emit(OtherUserInitial());
  }

  Future<void> removeFriend(String userId) async {
    emit(OtherUserNetworkAction());
    await friendPageCubit.removeFriend(userId);
    emit(OtherUserInitial());
  }

  Future<void> removeSentRequest(String userId) async {
    emit(OtherUserNetworkAction());
    await friendPageCubit.removeSentRequest(userId);
    emit(OtherUserInitial());
  }

  Future<void> removeFriendInvitation(String userId) async {
    emit(OtherUserNetworkAction());
    await friendPageCubit.removeFriendInvitation(userId);
    emit(OtherUserInitial());
  }

  Future<void> applyFriendRequest(String userId) async {
    emit(OtherUserNetworkAction());
    await friendPageCubit.applyFriendRequest(userId);
    emit(OtherUserInitial());
  }

}
