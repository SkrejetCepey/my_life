import 'package:flutter/material.dart';

abstract class DesireParticleModel {

  Widget skinView(BuildContext context);
  Scaffold addPage(BuildContext context);
  Scaffold editPage(BuildContext context);
  Widget build(BuildContext context);

}