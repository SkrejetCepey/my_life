import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/table_calendar/table_calendar_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/errors/my_life_error.dart';
import 'package:my_life/networking/connection.dart';
import 'package:my_life/pages/goals_page.dart';

import 'desire/desire.dart';
import 'icon_data_structure/icon_data_structure.dart';

class GoalsList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);
    List<Desire> goalsList = cubit.user.getActualGoalsList(BlocProvider.of<TableCalendarCubit>(context).actualDay);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 25.0,
          ),
          FutureBuilder(
            future: Connection.getGoalByDate(cubit.user,
                DateFormat.yMd().format(BlocProvider.of<TableCalendarCubit>(context).actualDay)),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {

                var s = (snapshot.data as List<Desire>).where((element) =>
                goalsList.where((el) => el.id == element.id).isEmpty);
                if (s.isNotEmpty) {
                  cubit.user.goalsList = List<Desire>.from(goalsList)..addAll(s);
                  cubit.user.save();
                  goalsList = List<Desire>.from(goalsList)..addAll(s);
                }
                goalsList = goalsList.map((Desire e) {
                  (snapshot.data as List<Desire>).forEach((Desire element) {
                  if (e.id != element.id && e.iconWebServerEnabled != null) {
                    e.iconWebServerEnabled = null;
                  } else if (e.id == element.id && e.iconWebServerEnabled == null) {
                    e.iconWebServerEnabled = IconDataStructure(Icons.autorenew_sharp.codePoint,
                        Icons.autorenew_sharp.fontFamily);
                  }
                });
                  return e;
                }).toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: goalsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Desire goal = goalsList[index];
                    print(goal.title);
                    return Card(
                      elevation: 2.0,
                      child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                              GoalsPage.edit(goal: goal)));
                        },
                        title: Row(
                          children: [
                            Container(
                                child: (goal.iconDataStructure == null) ? Icon(Icons.auto_awesome, size: 30.0) : Icon(goal.iconDataStructure?.iconData)
                            ),
                            SizedBox(
                              width: 25.0,
                            ),
                            Text('${goal.title}', style: TextStyle(
                                color: Colors.brown[700]
                            )),
                            Spacer(),
                            Icon(goal.iconWebServerEnabled?.iconData, color: Colors.green)
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                print("SNAPSHOT ERROR!");
                if ((snapshot.error as MLNetworkError).response.statusCode == 401 && cubit.user.role != "Guest") {
                  print("401 EXCEPTION!");
                  BlocProvider.of<UserCubit>(context).updateTokens().then((value) =>
                      BlocProvider.of<DesiresListCubit>(context).refresh(), onError: (e) {
                    print("KSKSKS");
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/home");
                  });
                } else if ((snapshot.error as MLNetworkError).response.statusCode == 401 && cubit.user.role == "Guest") {
                  return GuestGoals();
                } else if ((snapshot.error as MLNetworkError).response.statusCode == 404) {
                  return Center(
                    child: Text("Server is unavailable :C\n404!"),
                  );
                } else if ((snapshot.error as MLNetworkError).response.statusCode == 400) {
                  print("sssss");
                } else if ((snapshot.error as MLNetworkError).response.statusCode == 401) {
                  // Получение ключей!
                  return Container();
                }
                return Center(
                  child: Text("Unhandled exception"),
                );
              } else {
                return Builder(
                  builder: (BuildContext context) {
                    if (goalsList.isNotEmpty && cubit.user.role != "Guest") {
                      final DateTime actualDate = BlocProvider.of<TableCalendarCubit>(context).actualDay;
                      final List<Desire> listGoals = cubit.user.goalsList.where((element) => actualDate.year == element.dateTime.year && actualDate.month == element.dateTime.month && actualDate.day == element.dateTime.day).toList();
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: listGoals.length,
                        itemBuilder: (BuildContext context, int index) {
                          Desire goal = listGoals[index];
                          return Card(
                            elevation: 2.0,
                            child: ListTile(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                    GoalsPage.edit(goal: goal)));
                              },
                              title: Row(
                                children: [
                                  Container(
                                      child: (goal.iconDataStructure == null) ? Icon(Icons.auto_awesome, size: 30.0) : Icon(goal.iconDataStructure?.iconData)
                                  ),
                                  SizedBox(
                                    width: 25.0,
                                  ),
                                  Text('${goal.title}', style: TextStyle(
                                      color: Colors.brown[700]
                                  )),
                                  Spacer(),
                                  Icon(goal.iconWebServerEnabled?.iconData, color: Colors.green)
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (cubit.user.role == "Guest") {
                      return GuestGoals();
                    } else {
                      return Container();
                    }

                  },
                );
              }
            },
          ),

        ],
      ),
    );
  }
}

class GuestGoals extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);
    final DateTime actualDate = BlocProvider.of<TableCalendarCubit>(context).actualDay;
    final List<Desire> listGoals = cubit.user.goalsList.where((element) => actualDate.year == element.dateTime.year && actualDate.month == element.dateTime.month && actualDate.day == element.dateTime.day).toList();
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: listGoals.length,
      itemBuilder: (BuildContext context, int index) {
        Desire goal = listGoals[index];
        return Card(
          elevation: 2.0,
          child: ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                  GoalsPage.edit(goal: goal)));
            },
            title: Row(
              children: [
                Container(
                    child: (goal.iconDataStructure == null) ? Icon(Icons.auto_awesome, size: 30.0) : Icon(goal.iconDataStructure?.iconData)
                ),
                SizedBox(
                  width: 25.0,
                ),
                Text('${goal.title}', style: TextStyle(
                    color: Colors.brown[700]
                )),
                Spacer(),
                Icon(goal.iconWebServerEnabled?.iconData, color: Colors.green)
              ],
            ),
          ),
        );
      },
    );
  }
}