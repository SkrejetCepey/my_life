
import 'package:dio/dio.dart';

class MLNetworkError implements Exception {

  String msg;
  Response response;

  MLNetworkError({this.msg, this.response});

  @override
  String toString() => 'MLError: $msg';

}