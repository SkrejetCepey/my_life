import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:my_life/models/abstract_model.dart';
import 'package:my_life/models/desire/desire.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
class User extends HiveObject implements AbstractModel {

  // List<Achievement>;
  // List<Desire>;

  // Picture profilePic;
  @HiveField(0)
  String id;
  @HiveField(1)
  String username;
  @HiveField(2)
  String login;
  @HiveField(3)
  String password;

  @HiveField(4)
  String firstName;
  @HiveField(5)
  String lastName;
  @HiveField(6)
  String city;
  @HiveField(7)
  String email;

  @HiveField(8)
  List<Desire> desiresList = List<Desire>.empty(growable: true);

  @HiveField(9)
  String accessToken;
  @HiveField(10)
  String refreshToken;

  User({this.username, this.login, this.password,
    this.firstName, this.lastName, this.city, this.email, this.accessToken, this.refreshToken});

  User.fromMap(Map<String, dynamic> map) {
    properties = map;
  }

  @override
  Map<String, String> get properties => {
    'username': username,
    'login': login,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'city': city,
    'email' : email
  };

  @override
  set properties(Map<String, dynamic> s) {
    if (s['id'] != null)
      id = s['id'];
    if (s['username'] != null)
      username = s['username'];
    if (s['login'] != null)
      login = s['login'];
    if (s['password'] != null)
      password = s['password'];
    if (s['firstName'] != null)
      firstName = s['firstName'];
    if (s['lastName'] != null)
      lastName = s['lastName'];
    if (s['city'] != null)
      city = s['city'];
    if (s['email'] != null)
      email = s['email'];
  }

  Map<String, dynamic> getNotNullProperties() {
    return properties..removeWhere((key, value) => value == null);
  }

  String getNullJsonFromProperties() {
    return json.encode(properties);
  }

  String getJsonFromProperties() {

    Map<String, String> map = properties;
    properties.forEach((key, value) {
      if(value == null) {
        map.remove(key);
      }
    });

    return json.encode(map);
  }

  String getLoginModelJson() {

    return json.encode(<String, String>{
      "login": this.login,
      "password": this.password
    });

  }

  @override
  String toString() => getJsonFromProperties();
}