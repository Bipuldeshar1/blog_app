import 'dart:convert';

import 'package:http/http.dart' as http;

class LikeApi {
  static String _baseUrl = "http://192.168.1.67:8000/api/v1/like/";

  Future<dynamic> addLike(
    String id,
    String accessToken,
    String refreshToken,
  ) async {
    try {
      Uri uri = Uri.parse(_baseUrl + "add-like/$id");
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Refresh-Token': refreshToken,
        'Content-Type': 'application/json',
      };

      var response = await http.post(
        uri,
        headers: headers,
      );

      if (response.statusCode == 200) {
        var decoded = jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getLike(
      String id, String accessToken, String refreshToken) async {
    Uri uri = Uri.parse(_baseUrl + "count/$id");
    var headers = {
      'Authorization': 'Bearer $accessToken',
      'Refresh-Token': refreshToken,
      'Content-Type': 'application/json',
    };
    var response = await http.get(
      uri,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);
      int likeCount = decoded['data']['likeCount'];
      return likeCount;
    }
  }
}
