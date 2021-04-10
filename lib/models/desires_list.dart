import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_life/cubits/drop_down_list_arrow/drop_down_list_arrow_cubit.dart';
import 'package:my_life/cubits/main_page/desires_list_cubit.dart';
import 'package:my_life/desire_particles/desire_unit/desire_unit.dart';
import 'desire/desire.dart';

class DesiresList extends StatelessWidget {

  DesiresList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);

    return MultiBlocProvider(
        providers: [
          BlocProvider<DropDownListArrowCubit>(
            create: (_) => DropDownListArrowCubit(),
          ),
        ],
        child: BlocBuilder<DropDownListArrowCubit, DropDownListArrowState>(
          builder: (BuildContext context, DropDownListArrowState state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  ExpansionPanelList(
                    elevation: 2,
                    animationDuration: Duration(milliseconds: 500),
                    expansionCallback: (int index, bool isExpanded) {
                      if (cubit.desireList[index].particleModels.isEmpty) {
                        return null;
                      }
                      cubit.desireList[index].isExpanded = !cubit.desireList[index].isExpanded;
                      BlocProvider.of<DropDownListArrowCubit>(context)
                          .switchDropDownListState();
                    },
                    children: buildExpansionPanelList(context),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }

  List<ExpansionPanel> buildExpansionPanelList(BuildContext context) {
    List<ExpansionPanel> list = <ExpansionPanel>[];

    final DesiresListCubit cubit = BlocProvider.of<DesiresListCubit>(context);

    for (Desire desire in cubit.desireList) {
      DesireUnit desireUnit = DesireUnit(desire: desire);
      list.add(ExpansionPanel(
        body: desireUnit.getDesireParticleModelList(context),
        headerBuilder: (context, isExpanded) {
          return desireUnit;
        },
        isExpanded: desire.isExpanded,
      ));
    }

    return list;
  }
}