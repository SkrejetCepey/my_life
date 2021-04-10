import 'package:http/http.dart' as http;
import 'package:my_life/models/user/user.dart';

const SERVER_IP = 'https://reqres.in/api/users';

class Connection {

  User user;

  Connection(this.user);

  Future<String> tryConnect() async {

    var request = await http.post(Uri.parse('$SERVER_IP'),
        body: user.toString(),
        );

    print(user);
    print(request.statusCode);

    if (request.statusCode == 201) {
      return request.body;
    } else {
      await Future.delayed(Duration(seconds: 5));
      throw Exception('Connection failed!\nRequest timeout - 408');
    }

  }

}