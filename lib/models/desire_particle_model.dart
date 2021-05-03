import 'package:flutter/material.dart';
import 'package:my_life/models/desire/desire.dart';

abstract class DesireParticleModel {

  Widget skinView(BuildContext context);
  Scaffold addPage(BuildContext context);
  Scaffold editPage(BuildContext context, Desire desire);
  Widget build(BuildContext context, Desire desire);

  Widget buildUnique(BuildContext context, Desire desire);

  DesireParticleModel clone([DateTime dateTime, bool state]);

  bool state;
  DateTime dateTime;
  int id;

}