import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/errors/my_life_error.dart';
import 'package:my_life/networking/connection.dart';
import 'package:my_life/pages/goals_page.dart';

import 'desire/desire.dart';

class GoalsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 25.0,
          ),
          FutureBuilder(
            future: Connection.getAllUserGoals(cubit.user),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                var s = (snapshot.data as List<Desire>).where((element) =>
                  cubit.user.goalsList.where((el) => el.id == element.id).isEmpty);
                cubit.user.goalsList = List<Desire>.from(cubit.user.goalsList)..addAll(s);
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cubit.user.goalsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Desire goal = cubit.user.goalsList[index];
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
                if ((snapshot.error as MLNetworkError).response.statusCode == 401) {
                  print("401 EXCEPTION!");
                  BlocProvider.of<UserCubit>(context).updateTokens().then((value) =>
                      BlocProvider.of<DesiresListCubit>(context).refresh(), onError: (e) {
                    print("KSKSKS");
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/home");
                  });
                } else if ((snapshot.error as MLNetworkError).response.statusCode == 404) {
                  return Center(
                    child: Text("Server is unavailable :C\n404!"),
                  );
                } else if ((snapshot.error as MLNetworkError).response.statusCode == 400) {
                  print("sssss");
                  // Future.microtask(() => AlertException.showAlertDialog(context, snapshot.error.toString())).then((value)
                  // {
                  //   Future.wait([BlocProvider.of<UserCubit>(context).deleteUser()]).then((value) => Navigator.of(context).pop());
                  // });
                }
                return Center(
                  child: Text("Unhandled exception"),
                );
              } else {
                return Builder(
                  builder: (BuildContext context) {
                    if (BlocProvider.of<DesiresListCubit>(context).user.goalsList.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: cubit.user.goalsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Desire goal = cubit.user.goalsList[index];
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