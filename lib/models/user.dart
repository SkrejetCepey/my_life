import 'dart:convert';

class User {

  String username;
  String firstName;
  String lastName;
  String email;
  String password;

  String get fullName => '$firstName $lastName';

  String getJson() {
    return json.encode(<String, String>{
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password
    });
  }

  @override
  String toString() => getJson();
}