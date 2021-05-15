import 'package:flutter/material.dart';

//TODO rename this shit
class RoundedDaysWeekCheckbox extends StatelessWidget {

  final bool state;
  final String charWeek;

  final double height;
  final double width;
  final double circularRadius;
  final Function callback;

  RoundedDaysWeekCheckbox({this.state, this.charWeek, this.height = 30.0,
    this.width = 30.0, this.circularRadius = 25.0, @required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
          color: (state) ? const Color(0xffd5f111) : const Color(0xffa0b50e),
        ),
        width: width,
        height: height,
        child: TextButton(
          child: Text(charWeek, style: TextStyle(color: const Color(0xff574940))),
          onPressed: callback,
        ),
        // child: IconButton(
        //   icon: state ? Icon(Icons.check_circle_outline) : Icon(FontAwesomeIcons.circle),
        //   onPressed: () {
        //     BlocProvider.of<DesiresListCubit>(context).update(desire);
        //     BlocProvider.of<ParticleCheckboxCubit>(context).switchParticleCheckBoxState();
        //   },
        // )
    );
  }
}