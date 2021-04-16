import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_life/models/user/user.dart';

const String SERVER_IP = "http://mylife-web.somee.com/api/account";

Exception getException(http.Response request) {
  return Exception('Connection failed!\n${request.statusCode}\n${request.reasonPhrase}');
}

class Connection {

  static Future<String> login(User user) async {

    var request = await http.post(Uri.parse('$SERVER_IP/login'),
      body: user.getLoginModelJson(),
      headers: {'content-type': 'application/json'}
    );

    if (request.statusCode == 200) {
      return request.body;
    } else {
      throw getException(request);
    }
  }

  static Future<List<User>> getAllUsers() async {

    var request = await http.get(Uri.parse('$SERVER_IP/getallusers'));

    List<User> result = <User>[];

    if (request.statusCode == 200) {

      for (dynamic val in jsonDecode(request.body)) {
        result.add(User.fromMap(val as Map));
      }

      return result;

    } else {
      throw getException(request);
    }

  }

  static Future<User> getUser(String id) async {

    var request = await http.get(Uri.parse('$SERVER_IP/getuser/$id'));

    if (request.statusCode == 200) {

      return User.fromMap(jsonDecode(request.body) as Map);

    } else {
      throw getException(request);
    }
  }

}