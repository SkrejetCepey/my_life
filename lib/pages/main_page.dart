import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/appbar_builder/appbar_builder_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/table_calendar/table_calendar_cubit.dart';
import 'package:my_life/cubits/user/user_cubit.dart';
import 'package:my_life/db/user_hive_repository.dart';
import 'package:my_life/models/desires_list.dart';
import 'desire_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'drawer_page.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<TableCalendarCubit, TableCalendarState>(
      builder: (context, state) {
        return Scaffold(
            drawerEdgeDragWidth: 0,
            appBar: AppBar(
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon: DecoratedIcon(
                      FontAwesomeIcons.listUl,
                      size: 30.0,
                      shadows: [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(3.0, 3.0)
                        )
                      ],
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  );
                },
              ),
              actions: [
                IconButton(
                    color: Colors.white,
                    iconSize: 40.0,
                    icon: DecoratedIcon(
                      FontAwesomeIcons.plus,
                      size: 30.0,
                      shadows: [
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(3.0, 3.0)
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                          DesirePage.add()));
                    }
                ),
              ],
              title: BlocBuilder<AppBarBuilderCubit, AppBarBuilderState>(
                builder: (BuildContext context, AppBarBuilderState state) {
                  return Align(
                    alignment: Alignment.center,
                    child: (BlocProvider.of<DesiresListCubit>(context).state is DesiresListInitialisedEmpty)
                        ? Text('') : BlocProvider.of<AppBarBuilderCubit>(context).getCurrentDateWidget(context),
                  );
                },
              ),
            ),
            body: BlocBuilder<DesiresListCubit, DesiresListState>(
              builder: (BuildContext context, DesiresListState state) {
                if (state is DesiresListInitialisedEmpty)
                  return HelloNewbiePage();
                else if (state is DesiresListInitialised)
                  return InitialisedDesiresListPage();
                else {
                  return ConnectToDatabaseLoadingBar();
                }
              },
            ),
            drawer: DrawerPage()
        );
      },
    );
  }
}

class InitialisedDesiresListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final DesiresListCubit _cubit = BlocProvider.of<DesiresListCubit>(context);
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
    final CalendarController calendarController = CalendarController();

    return  RefreshIndicator(
      key: _refreshKey,
      onRefresh: _cubit.refresh,
      child: DefaultTabController(
        length: 2,
        child: Column(
            children: [
              // Material(
              //   color: const Color(0xffa0b50e),
              //   child: TabBar(
              //     indicatorColor: const Color(0xffd5f111),
              //     unselectedLabelColor: const Color(0xffc2c19a),
              //     labelColor: const Color(0xffd5f111),
              //     tabs: [
              //       Tab(child: Text('Habits')),
              //       Tab(child: Text('Desires'))
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 30.0,
              ),
              TableCalendar(
                locale: 'ru_RU',
                headerVisible: false,
                builders: CalendarBuilders(
                  todayDayBuilder: (context, date, events) {
                    return Container(
                      child: Center(child: Text('${date.day}',
                        style: TextStyle(
                          color: (date.weekday == 6 || date.weekday == 7) ? Colors.red : Colors.black
                        )),),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color(0xffd5f111),
                              width: 2
                          ),
                          shape: BoxShape.circle
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                    );
                  },
                  selectedDayBuilder: (context, date, events) {

                    BlocProvider.of<AppBarBuilderCubit>(context).dateTime = date;

                    print(date.weekday);
                    return Container(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Center(
                            child: Text('${date.day}',
                            style: TextStyle(
                              color: (date.weekday == 6 || date.weekday == 7) ? Colors.red : Colors.black
                            ),
                            ),
                          ),
                          Container(
                            height: 4.0,
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                shape: BoxShape.circle
                            ),
                            margin: EdgeInsets.symmetric(vertical: 15.0),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                calendarStyle: CalendarStyle(
                    selectedColor: Color(0xffb4baba)
                ),
                onDaySelected: (day, events, holidays) {
                  BlocProvider.of<TableCalendarCubit>(context).selectNewDay(day);
                  calendarController.setFocusedDay(day);

                  //TODO WTF THIS SHIT
                  BlocProvider.of<DesiresListCubit>(context).refresh();
                },
                initialSelectedDay: BlocProvider.of<TableCalendarCubit>(context).actualDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                initialCalendarFormat: CalendarFormat.week,
                calendarController: calendarController,
                headerStyle: HeaderStyle(
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleTextBuilder: (date, locale) {
                    BlocProvider.of<AppBarBuilderCubit>(context).dateTime = date;
                    return '';
                  },
                ),
                availableCalendarFormats: {CalendarFormat.week : 'Week'},
              ),
              Expanded(
                  child: DesiresList()
              ),
            ]
        ),
      ),
    );
  }

}

class ConnectToDatabaseLoadingBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('DesiresListCubit(User): ${BlocProvider.of<DesiresListCubit>(context).user}'),
          Text('UserCubit(User): ${BlocProvider.of<UserCubit>(context).user}'),
          Text('UserCubit(state): ${BlocProvider.of<UserCubit>(context).state}'),
          Text('DesiresListCubit(state): ${BlocProvider.of<DesiresListCubit>(context).state}'),
          Text('UserHiveRep: ${UserHiveRepository.db.getAll().then((value) => value)}'),
          Text('Connecting to local database...'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}

class HelloNewbiePage extends StatelessWidget {

  final TextStyle _textStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30.0,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(25.0),
          alignment: Alignment.topCenter,
          child: Text('Hello,\n${BlocProvider.of<DesiresListCubit>(context).user.login}!', style: _textStyle),
        ),
        Container(
          padding: EdgeInsets.all(25.0),
          alignment: Alignment.topCenter,
          child: Text('You look like newbie here!', style: _textStyle),
        ),
        Container(
          padding: EdgeInsets.all(25.0),
          alignment: Alignment.topCenter,
          child: Text('Start by adding a new desire at the top right!', style: _textStyle),
        ),
      ],
    );
  }

}