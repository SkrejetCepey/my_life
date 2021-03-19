import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/drop_down_list_arrow/drop_down_list_arrow_cubit.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:meta/meta.dart';
import 'package:my_life/models/desire_particle_model.dart';
import 'package:my_life/pages/desire_page.dart';

class DesireUnit extends StatelessWidget {

  final Desire desire;

  DesireUnit({@required this.desire});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DropDownListArrowCubit>(
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