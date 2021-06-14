import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_life/cubits/table_calendar/table_calendar_cubit.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:meta/meta.dart';
import 'package:my_life/models/desire_particle_model.dart';
import 'package:my_life/pages/desire_page.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DesireUnit extends StatelessWidget {

  final Desire desire;
  final SlidableController slidableController;

  DesireUnit({@required this.desire, @required this.slidableController});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
            DesirePage.edit(desire: desire)));
      },
      title: Container(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                      child: (desire.iconDataStructure == null) ? Icon(Icons.auto_awesome, size: 30.0) : Icon(desire.iconDataStructure?.iconData)
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Text('${desire.title}', style: TextStyle(
                      color: Colors.brown[700]
                  )),
                  Spacer(),
                ],
              ),
            ],
          )
      ),
    );
  }

  Widget getDesireParticleModelList(BuildContext context) {
    return Column(
      children: <Widget>[
        for (DesireParticleModel entry in desire.particleModels) Column(
          children: [
            Divider(),
            entry.build(context, desire)
          ],
        ),
      ],
    );
  }

  Widget getDesireParticleModelListWithDate(BuildContext context) {

    DateTime actualDate = BlocProvider.of<TableCalendarCubit>(context).actualDay;

    return Column(
      children: <Widget>[
        for (DesireParticleModel entry in desire.particleModels
        //     .where((element) {
        //   if (element.dateTime?.day == actualDate.day &&
        //       element.dateTime.month == actualDate.month &&
        //       element.dateTime.year == actualDate.year) {
        //     return true;
        //   } else {
        //     return false;
        //   }
        // })
        )
          Column(
          children: [
            Divider(),
            Slidable(
              controller: slidableController,
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: entry.build(context, desire),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'OK',
                  color: Colors.green,
                  icon: Icons.check,
                ),
                IconSlideAction(
                  caption: 'Plus',
                  color: Colors.orange,
                  icon: Icons.plus_one,
                )
              ],
              secondaryActions: [
                IconSlideAction(
                  caption: 'Delete',
                  color: Colors.red,
                  icon: Icons.delete,
                ),
                IconSlideAction(
                  caption: 'Skip',
                  color: Colors.black,
                  icon: Icons.skip_next,
                )
              ],
            ),
            FAProgressBar(
              animatedDuration: Duration(seconds: 0),
              currentValue: desire.getValueCompleteCurrentParticleInPercent(entry),
              size: 3.0,
              progressColor: const Color(0xffd5f111),
              direction: Axis.horizontal,
              maxValue: 100,
            ),
          ],
        ),
      ],
    );
  }

}



class RadialFillingIcon extends StatelessWidget {

  final Desire desire;

  RadialFillingIcon({@required this.desire});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 1,
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                axisLineStyle: AxisLineStyle(
                  color: const Color(0xffb4baba),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: desire.getValueCompleteParticles(),
                    color: const Color(0xffd5f111),
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
              )
            ],
          ),
          Container(
              child: (desire.iconDataStructure == null) ? Icon(Icons.auto_awesome, size: 30.0) : Icon(desire.iconDataStructure?.iconData)
          )
        ],
      ),
    );
  }
}