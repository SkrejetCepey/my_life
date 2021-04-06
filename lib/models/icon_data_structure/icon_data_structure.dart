import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'icon_data_structure.g.dart';

@HiveType(typeId: 2)
class IconDataStructure extends HiveObject {

  @HiveField(0)
  int unicode;
  @HiveField(1)
  String fontFamily;

  IconDataStructure(this.unicode, this.fontFamily);

  IconData get iconData => IconData(this.unicode, fontFamily: this.fontFamily);
}