import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/model/userModel.dart';
import 'package:frontend/views/homepage.dart';
import 'package:frontend/views/loginsignup/login.dart';
import 'package:http/http.dart' as http;

class UserApi {
  // static String _baseUrlLogin = 'http://127.0.0.1:8000/api/v1/user/';
  static String _baseUrlLogin = 'http://192.168.1.67:8000/api/v1/user/';
  Future<dynamic> login(UserModel user, context) async {
    try {
      Uri requestUri = Uri.parse(_baseUrlLogin + "login");

      var response = await http.post(
        requestUri,
        body: jsonEncode(user.toJson()),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);

        var x = decoded['success'];

        if (x == true) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                      accessToken: decoded['data']['accessToken'],
                      refreshToken: decoded['data']['refreshToken'])));
          return decoded['data']['loggedInUser'];
        } else {
          print('x');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please check your credentials.');
      } else {
        throw Exception('Failed to log in: ${response.statusCode}');
      }
    } catch (error) {
      // Log error for debugging
      print('Login error: $error');
      // Rethrow the error to propagate it
    }
  }

  Future<dynamic> register(UserModel user, context) async {
    try {
      var uri = Uri.parse(_baseUrlLogin + 'register');

      var response = await http.post(
        uri,
        body: jsonEncode(user.toJson()),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);

        var x = decoded['success'];

        if (x == true) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        } else {
          print('x');
        }
      }
    } catch (e) {
      print('register error: $e');
    }
  }
}
