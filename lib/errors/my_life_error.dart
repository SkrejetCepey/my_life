
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
      return '${response.statusCode}\n${response.statusMessage}\n${response.data['errorMessage']}';
    } else {
      return 'Silence MLNetworkError!';
    }
  }

}