import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/pages/desire_page.dart';
import 'desire/desire.dart';

class DesiresList extends StatelessWidget {

  DesiresList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);

    return ListView.builder(
      itemCount: cubit.desireList.length,
      itemBuilder: (BuildContext context, int index) {
        Desire desire = cubit.desireList[index];
        return Container(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Card(
            elevation: 8.0,
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                    DesirePage.edit(desire: desire)));
              },
              title: Container(
                  child: Row(
                    children: [
                      Text('${desire.title}')
                    ],
                  )
              ),
            ),
          ),
        );
      },
    );
  }

}