import 'dart:convert';
import 'package:my_life/models/abstract_model.dart';

class User extends AbstractModel {

  Map<String, String> _properties = Map<String, String>();

  void add(String key, String value) => _properties[key] = value;

  String getJsonFromProperties() {
    return json.encode(_properties);
  }

  @override
  String toString() => getJsonFromProperties();
}