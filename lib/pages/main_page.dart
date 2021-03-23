import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/models/desires_list.dart';
import 'desire_page.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          iconSize: 40.0,
          icon: Icon(FontAwesomeIcons.userCircle),
          onPressed: () {
            print('tapped on user!');
          },
        ),
        actions: [
          IconButton(
            color: Colors.white,
            iconSize: 40.0,
              icon: Icon(FontAwesomeIcons.plus),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                    DesirePage.add()));
              }
          ),
        ],
        title: Text('MY DESIRES',
            style: TextStyle(
              color: Colors.brown[600]
            )),
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
    );
  }
}

class InitialisedDesiresListPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final DesiresListCubit _cubit = BlocProvider.of<DesiresListCubit>(context);
    final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();

    return RefreshIndicator(
        key: _refreshKey,
        onRefresh: _cubit.refresh,
        child: Column(
            children: [
              TableCalendar(
                locale: 'ru_RU',
                initialCalendarFormat: CalendarFormat.week,
                  calendarController: CalendarController(),
                availableCalendarFormats: {CalendarFormat.week : 'Weeks'},
              ),
              Expanded(
                  child: DesiresList()
              )
            ]
        )
    );
  }

}

class ConnectToDatabaseLoadingBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
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
          child: Text('Hello,\nguest!', style: _textStyle),
        ),
        Container(
          padding: EdgeInsets.all(25.0),
          alignment: Alignment.topCenter,
          child: Text('You look like newbie here!', style: _textStyle),
        ),
        Container(
          padding: EdgeInsets.all(25.0),
          alignment: Alignment.topCenter,
          child: Text('Start by adding a new target at the bottom right!', style: _textStyle),
        )
      ],
    );
  }

}