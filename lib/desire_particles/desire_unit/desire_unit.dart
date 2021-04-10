import 'package:flutter/material.dart';
import 'package:my_life/models/desire/desire.dart';
import 'package:meta/meta.dart';
import 'package:my_life/models/desire_particle_model.dart';
import 'package:my_life/pages/desire_page.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class DesireUnit extends StatelessWidget {

  final Desire desire;

  DesireUnit({@required this.desire});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
            DesirePage.edit(desire: desire)));
      },
      title: Container(
          child: Row(
            children: <Widget>[
              RadialFillingIcon(desire: desire),
              SizedBox(
                width: 25.0,
              ),
              Text('${desire.title}', style: TextStyle(
                  color: Colors.brown[700]
              )),
              Spacer(),
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
                    width: 0.95,
                    color: const Color(0xffd5f111),
                    sizeUnit: GaugeSizeUnit.factor,
                  )
                ],
              )
            ],
          ),
          Container(
              child: Icon(desire.iconDataStructure?.iconData)
          )
        ],
      ),
    );
  }
}