import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/model/blog.model.dart';
import 'package:frontend/model/userModel.dart';
import 'package:frontend/views/homepage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // static String _baseUrl = 'http://127.0.0.1:8000/api/v1/blog/';
  static String _baseUrl = 'http://192.168.1.67:8000/api/v1/blog/';

  Future<void> addBlog(
      BlogModel blog, String accessToken, String refreshToken) async {
    try {
      Uri requestUri = Uri.parse(_baseUrl + "addBlog");
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Refresh-Token': refreshToken,
        'Content-Type': 'application/json',
      };
      var response = await http.post(
        requestUri,
        headers: headers,
        body: jsonEncode(blog.toJson()),
      );

      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
      } else {
        throw Exception('Failed to add blog: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to add blog: $error');
    }
  }

  Future<void> deleteBlog(
    BlogModel blog,
    String accessToken,
    String refreshToken,
  ) async {
    Uri requestUri = Uri.parse(_baseUrl + "delete/${blog.id}");
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Refresh-Token': 'Bearer $refreshToken',
    };
    var response = await http.delete(
      requestUri,
      headers: headers,
    );
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  Future<List<BlogModel>> fetchBlog(
      String accessToken, String refreshToken) async {
    try {
      print('fetching...');
      Map<String, String> headers = {
        'Authorization': 'Bearer $accessToken',
        'Refresh-Token': refreshToken,
        'Content-Type': 'application/json',
      };
      Uri requestUri = Uri.parse(_baseUrl + "getAll");
      var response = await http.get(requestUri, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> decoded = jsonDecode(response.body);
        List<dynamic> blogData =
            decoded['data']['blogs']; // Accessing 'blogs' inside 'data'
        List<BlogModel> blogs = blogData
            .map<BlogModel>((json) => BlogModel.fromJson(json))
            .toList();
        print('aaa      ${blogs[0].title}');
        return blogs;
      } else {
        throw Exception('Failed to fetch blogs: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to fetch blogs: $error');
    }
  }
}
