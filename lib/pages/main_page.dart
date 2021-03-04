import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/models/desires_list.dart';

class MainPage extends StatelessWidget {

  final DesiresListCubit _mainPageCubit = DesiresListCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _mainPageCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('MainPage'),
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/add_desire', arguments: _mainPageCubit);
          },
        ),
      )
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
      child: DesiresList(cubit: _cubit),
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