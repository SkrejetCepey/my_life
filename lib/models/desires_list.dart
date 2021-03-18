import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/drop_down_list_arrow/drop_down_list_arrow_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/pages/desire_page.dart';
import 'desire/desire.dart';
import 'desire_particle_model.dart';

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
                  child: BlocProvider<DropDownListArrowCubit>(
                    create: (_) => DropDownListArrowCubit(),
                    child: BlocBuilder<DropDownListArrowCubit, bool>(
                      builder: (BuildContext context, bool state) {
                        return ListTile(
                          subtitle: state ? _getColumnWithParticleModels(desire.particleModels, context) : null,
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                                DesirePage.edit(desire: desire)));
                          },
                          title: Container(
                              child: Row(
                                children: <Widget>[
                                  Text('${desire.title}'),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(Icons.arrow_downward_outlined),
                                    onPressed: () {
                                      BlocProvider.of<DropDownListArrowCubit>(context).switchDropDownListState();
                                    },
                                  )
                                ],
                              )
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
  }

  Widget _getColumnWithParticleModels(List<DesireParticleModel> listParticles, BuildContext context) {
    return Column(
      children: <Widget>[
        for (DesireParticleModel entry in listParticles) Column(
          children: [
            Divider(),
            entry.build(context)
          ],
        ),
      ],
    );
  }

}