import 'package:flutter/material.dart';
import 'package:my_life/models/desire/desire.dart';

abstract class DesireParticleModel {

  Widget skinView(BuildContext context);
  Scaffold addPage(BuildContext context);
  Scaffold editPage(BuildContext context, Desire desire);
  Widget build(BuildContext context, Desire desire);

  bool state;

}