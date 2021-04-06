import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:my_life/models/abstract_model.dart';

part 'user.g.dart';

@HiveType(typeId: 3)
class User extends HiveObject implements AbstractModel {

  // List<Achievement>;ыукs
  // List<Desire>;

  // Picture profilePic;
  @HiveField(0)
  String nickname;
  @HiveField(1)
  String login;
  @HiveField(2)
  String password;

  @HiveField(3)
  String firstName;
  @HiveField(4)
  String lastName;
  @HiveField(5)
  String city;
  @HiveField(6)
  String email;

  User({this.nickname, this.login, this.password,
    this.firstName, this.lastName, this.city, this.email});

  @override
  Map<String, String> get properties => {
    'nickname': nickname,
    'login': login,
    'password': password,
    'firstName': firstName,
    'lastName': lastName,
    'city': city,
    'email' : email
  };

  @override
  set properties(Map<String, String> s) {
    if (s['nickname'] != null)
      nickname = s['nickname'];
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

  String getJsonFromProperties() {

    Map<String, String> map = properties;
    properties.forEach((key, value) {
      if(value == null) {
        map.remove(key);
      }
    });

    return json.encode(map);
  }

  @override
  String toString() => getJsonFromProperties();
}