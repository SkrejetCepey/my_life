import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:my_life/errors/my_life_error.dart';
import 'dart:convert';
import 'package:my_life/models/user/user.dart';

const String SERVER_IP = "http://mylife-web.somee.com/api";
final Dio _dio = Dio();

MLNetworkError getException(Response response) {
  return MLNetworkError(response: response);
}

class Connection {

  static Future<String> login(User user) async {

    try {
      var request = await _dio.postUri(Uri.parse('$SERVER_IP/auth/login'),
          data: user.getLoginModelJson(),
          options: Options(headers: {'content-type': 'application/json'})
      );

      return request.toString();

    } on DioError catch (e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }

  }

  static Future<Map<String, dynamic>> refreshTokens(User user) async {
    try {

      var request = await _dio.postUri(Uri.parse('$SERVER_IP/auth/refresh'),
          data: json.encode({'RefreshToken': user.refreshToken}),
          options: Options(headers: {'content-type': 'application/json'})
      );

      return request.data as Map<String, dynamic>;

    } on DioError catch(e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }
  }

  static Future<String> register(User user) async {

    try {

      var request = await _dio.postUri(Uri.parse('$SERVER_IP/auth/register'),
          data: user.getNullJsonFromProperties(),
          options: Options(headers: {'content-type': 'application/json'})
      );

      return request.toString();
    } on DioError catch(e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }

  }

  static Future<List<User>> getSendInvites(User user) async {

    List<User> result = <User>[];

    try {

      var request = await _dio.getUri(Uri.parse('$SERVER_IP/friends/sent'),
          options: Options(headers: {'content-type': 'application/json',
            "Authorization": "Bearer ${user.accessToken}"})
      );

      for (dynamic val in request.data) {
        result.add(User.fromMap(val as Map));
      }

      return result;

    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        return result;
      } else {
        print('Exception: ${e.response.statusCode} / ${e.response.data}');
        throw getException(e.response);
      }
    }
  }

  static Future<void> sentFriendRequest(User user, String friendId) async {

    try {

      var formData = FormData.fromMap({'id': friendId});

      await _dio.postUri(Uri.parse('$SERVER_IP/friends/sent'),
          data: formData,
          options: Options(headers: {'content-type': 'application/json',
          "Authorization": "Bearer ${user.accessToken}"})
      );

    } on DioError catch (e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }

  }

  static Future<List<User>> getReceiveFriendList(User user) async {

    List<User> result = <User>[];

    try {

      var request = await _dio.getUri(Uri.parse('$SERVER_IP/friends/received'),
          options: Options(headers: {'content-type': 'application/json',
            "Authorization": "Bearer ${user.accessToken}"})
      );

      for (dynamic val in request.data) {
        print(val as Map);
        result.add(User.fromMap(val as Map));
      }

      return result;

    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        return result;
      } else {
        print('Exception: ${e.response.statusCode} / ${e.response.data}');
        throw getException(e.response);
      }
    }
  }

  static Future<void> removeFriendInvitation(User user, String friendId) async {

    try {

      var formData = FormData.fromMap({'id': friendId});

      await _dio.deleteUri(Uri.parse('$SERVER_IP/friends/received'),
          data: formData,
          options: Options(headers: {'content-type': 'application/json',
            "Authorization": "Bearer ${user.accessToken}"})
      );

    } on DioError catch (e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }

  }

  static Future<void> applyFriendRequest(User user, String friendId) async {

    try {

      var formData = FormData.fromMap({'id': friendId});

      await _dio.postUri(Uri.parse('$SERVER_IP/friends/received'),
          data: formData,
          options: Options(headers: {'content-type': 'application/json',
            "Authorization": "Bearer ${user.accessToken}"})
      );

    } on DioError catch (e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }


  }

  static Future<List<User>> getMyFriends(User user) async {

    List<User> result = <User>[];

    try {
      var request = await _dio.getUri(Uri.parse('$SERVER_IP/friends'),
          options: Options(headers: {'content-type': 'application/json',
            "Authorization": "Bearer ${user.accessToken}"})
      );

      for (dynamic val in request.data) {
        result.add(User.fromMap(val as Map));
      }

      return result;

    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        return result;
      } else {
        print('Exception: ${e.response.statusCode} / ${e.response.data}');
        throw getException(e.response);
      }
    }

  }

  static Future<void> removeFriend(User user, String friendId) async {

    var formData = FormData.fromMap({'id': friendId});

    try {
      await _dio.deleteUri(Uri.parse('$SERVER_IP/friends'),
          data: formData,
          options: Options(headers: {'content-type': 'application/json',
            "Authorization": "Bearer ${user.accessToken}"})
      );
    } on DioError catch(e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }
  }

  static Future<void> removeSentRequest(User user, String userSentRequest) async {

    var formData = FormData.fromMap({'id': userSentRequest});

    try {
      await _dio.deleteUri(Uri.parse('$SERVER_IP/friends/sent'),
          data: formData,
          options: Options(headers: {'content-type': 'application/json',
            "Authorization": "Bearer ${user.accessToken}"})
      );
    } on DioError catch(e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }

  }

  static Future<List<User>> getAllUsers(User user, BuildContext context) async {

    try {
      var request = await _dio.getUri(Uri.parse('$SERVER_IP/friends/find'),
          options: Options(headers: {'content-type': 'application/json',
            "Authorization": "Bearer ${user.accessToken}"})
      );

      List<User> result = <User>[];

      for (dynamic val in request.data) {
        result.add(User.fromMap(val as Map));
      }
      return result;

    } on DioError catch (e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }
  }

  @deprecated
  static Future<User> getUser(User user, String id) async {

    try {
      var request = await _dio.getUri(Uri.parse('$SERVER_IP/getuser/$id'),
          options: Options(headers: {'content-type': 'application/json',
            "Authorization": "Bearer ${user.accessToken}"})
      );

      return User.fromMap(request.data as Map);

    } on DioError catch(e) {
      print('Exception: ${e.response.statusCode} / ${e.response.data}');
      throw getException(e.response);
    }
  }

}