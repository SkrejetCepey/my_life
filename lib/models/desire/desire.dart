import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:my_life/models/abstract_model.dart';
import 'package:my_life/models/icon_data_structure/icon_data_structure.dart';
import 'package:my_life/models/progress/progress.dart';
import '../desire_particle_model.dart';

part 'desire.g.dart';

@HiveType(typeId: 0)
class Desire extends HiveObject implements AbstractModel {

  @HiveField(0)
  String title;
  @HiveField(1)
  IconDataStructure iconDataStructure;
  @HiveField(2)
  String description;
  @HiveField(3)
  List<DesireParticleModel> particleModels = List<DesireParticleModel>.empty(growable: true);
  @HiveField(4)
  DateTime dateTime;

  @HiveField(5)
  List<Progress> progress = List<Progress>.empty(growable: true);

  @HiveField(6)
  String id;

  @HiveField(7)
  IconDataStructure iconWebServerEnabled;

  bool isExpanded = false;

  Desire({this.title});

  Desire.targetDriver(Map<String, dynamic> map) {
    this.title = map["title"];
    this.id = map["id"];
    // print(map["progress"].first["date"]);

    this.iconWebServerEnabled = IconDataStructure(Icons.autorenew_sharp.codePoint,
        Icons.autorenew_sharp.fontFamily);

    try {
      this.dateTime = DateFormat("M/d/yyyy HH:mm:s a").parse(map["progress"].first["date"]);
    } on FormatException catch(e) {
      this.dateTime = null;
    }

  }

  bool isEmpty() => (title == null);

  @override
  Map<String, String> get properties => {
    'title': title,
    'description': description
  };

  @override
  set properties(Map<String, dynamic> s) {
    if (s['title'] != null)
      title = s['title'];
    if (s['description'] != null)
      description = s['description'];
  }

  String getTargetProperties() {
    return json.encode(<String, dynamic>{"title": this.title,
      "progress" : [{"date": (dateTime != null) ? DateFormat.yMd().add_jm().format(dateTime) : null, "value": {"maxValue": 1, "currentValue": 0}}]});
  }

  String getTargetPropertiesForUpdate() {
    return json.encode(<String, dynamic>{"id": this.id, "title": this.title,
      "progress" : [{"date": (dateTime != null) ? DateFormat.yMd().add_jm().format(dateTime) : null, "value": {"maxValue": 1, "currentValue": 0}}]});
  }

  double getValueCompleteParticles() {

    if (particleModels.isEmpty)
      return 0;

    print(particleModels
        .where((element) => element.state != false)
        .length / particleModels.length);

    return particleModels
        .where((element) => element.state != false)
        .length / particleModels.length;
  }

  int getValueCompleteParticlesInCount() {

    if (particleModels.isEmpty)
      return 0;

    return particleModels
        .where((element) => element.state != false)
        .length;
  }

  int getValueCompleteParticlesInPercent() {

    if (particleModels.isEmpty)
      return 0;

    return (particleModels
        .where((element) => element.state != false)
        .length / particleModels.length * 100).round();
  }

  int getValueCompleteCurrentParticleInPercent(DesireParticleModel desireParticleModel) {

    if (particleModels.isEmpty)
      return 0;

    List<DesireParticleModel> t =  particleModels
        .where((element) => desireParticleModel == element).toList();

    return (t.where((element) => element.state != false).length / t.length * 100).round();

  }

  @override
  String toString() {
    return 'Desire($title, ${particleModels.length})';
  }
}