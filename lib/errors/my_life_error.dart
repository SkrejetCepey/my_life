
import 'package:dio/dio.dart';

class MLNetworkError implements Exception {

  String msg;
  Response response;

  MLNetworkError({this.msg, this.response});

  @override
  String toString() {
    if (msg != null) {
      return 'MLNetworkError: $msg';
    } else if (response != null) {
      if (response.statusCode == 500 || response.statusCode == 404) {
        return '${response.statusCode}\n${response.statusMessage}\n"Server is unavailable!"';
      } else if (response.statusCode == 401) {
        return '${response.statusCode}\n${response.statusMessage}\n"Server is unavailable!"';
      } else {
        print(response.data);
        return '${response.statusCode}\n${response.statusMessage}\n${response.data['errorMessage']}';
      }
    } else {
      return 'Silence MLNetworkError!';
    }
  }


}