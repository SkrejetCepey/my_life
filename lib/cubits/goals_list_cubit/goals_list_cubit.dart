import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:my_life/models/user/user.dart';

part 'goals_list_state.dart';

@deprecated
class GoalsListCubit extends Cubit<GoalsListState> {

  List<Desire> goalsList = <Desire>[];
  User user;
  BuildContext context;

  GoalsListCubit(this.context) : super(GoalsListInitial()) {
    _getUserAndInit();
  }

  Future<void> _getUserAndInit() async {

    User user = BlocProvider.of<UserCubit>(context).user;
    this.user = user;
    await _init();
  }

  Future<void> _init() async {

    this.goalsList = user.goalsList;

    goalsList.forEach((element) { print(element.title);});
    print('goalsList.length: ${goalsList.length}');

    if (goalsList.isEmpty)
      emit(GoalsListInitialEmpty());
    else
      emit(GoalsListInitialised());
  }

  Future<void> refresh(BuildContext context) async {
    this.context = context;
    await _getUserAndInit();
  }

  Future<void> add(Desire goal) async {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);

    emit(GoalsListAddItem());
    await cubit.addGoal(goal);

    await _init();
  }
}
