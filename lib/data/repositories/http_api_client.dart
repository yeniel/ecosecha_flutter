import 'dart:convert';

import 'package:ecosecha_flutter/data/data.dart';
import 'package:http/http.dart' as http;

class HttpApiClient implements ApiClient {
  final String _host = 'http://46.26.119.128:8081/';
  final String _basePath = 'WebServicesGneisServer/rest/';

  @override
  Future<Map<String, dynamic>> get({required String path}) async {
    final response = await http.get(
      Uri.parse(_host + _basePath + path),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get $path');
    }
  }

  @override
  Future<Map<String, dynamic>> post({required String path, required Map<String, String> body}) async {
    final response = await http.post(
      Uri.parse(_host + _basePath + path),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post $path');
    }
  }
}
