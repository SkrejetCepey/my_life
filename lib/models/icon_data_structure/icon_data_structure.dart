import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'icon_data_structure.g.dart';

@HiveType(typeId: 2)
class IconDataStructure extends HiveObject {

  @HiveField(0)
  int _unicode;
  @HiveField(1)
  String _fontFamily;

  IconDataStructure(unicode, fontFamily) {
    this._unicode = unicode;
    this._fontFamily = fontFamily;
  }

  IconData get iconData => IconData(_unicode, fontFamily: _fontFamily);
}