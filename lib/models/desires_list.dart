import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/cubits/table_calendar/table_calendar_cubit.dart';
import 'package:my_life/desire_particles/desire_unit/desire_unit.dart';
import 'desire/desire.dart';

class DesiresList extends StatelessWidget {

  DesiresList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);
    final SlidableController slidableController = SlidableController();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 25.0,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cubit.actualDesires(BlocProvider.of<TableCalendarCubit>(context).actualDay).length,
            itemBuilder: (BuildContext context, int index) {
              Desire desire = cubit.actualDesires(BlocProvider.of<TableCalendarCubit>(context).actualDay)[index];
              DesireUnit desireUnit = DesireUnit(desire: desire, slidableController: slidableController);

              return Card(
                elevation: 2.0,
                child: ExpansionTile(
                  trailing: (desire.particleModels.isEmpty) ? SizedBox.shrink() : null,
                  onExpansionChanged: (value) {
                    if (desire.particleModels.isEmpty)
                      return null;
                    desire.isExpanded = !desire.isExpanded;
                  },
                  initiallyExpanded: desire.isExpanded,
                  title: desireUnit,
                  children: [
                    desireUnit.getDesireParticleModelListWithDate(context),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}