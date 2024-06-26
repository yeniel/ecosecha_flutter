import 'dart:convert';

import 'package:data/data.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';

class HttpApiClient implements ApiClient {
  HttpApiClient() {
    // client = RetryClient(Client(), when: _retryWhen, onRetry: _onRetry);
    client = RetryClient(Client());
  }

  final String _host = 'https://81.0.53.24:8443/';
  final String _basePath = 'WebServicesGneisServer/rest/';
  late RetryClient client;

  // bool _retryWhen(BaseResponse response) {
  //   return response.statusCode >= 400;
  // }
  //
  // Future<void> _onRetry(BaseRequest request, BaseResponse? response, int retryCount) async {
  //   if (response?.statusCode == 400 || response?.statusCode == 405) {
  //
  //   }
  // }

  @override
  Future<Map<String, dynamic>> get({required String path}) async {
    final response = await client.get(
      Uri.parse(_host + _basePath + path),
      headers: {'Content-Type': 'application/json'},
    ).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get $path');
    }
  }

  @override
  Future<Map<String, dynamic>> post({required String path, required Map<String, dynamic> body}) async {
    final response = await client.post(
      Uri.parse(_host + _basePath + path),
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    ).timeout(const Duration(seconds: 30));

    // if (kDebugMode) {
    //   print(String.fromCharCodes(response.bodyBytes));
    // }

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 400 || response.statusCode == 401 || response.statusCode == 405) {
      throw ExpiredToken();
    } else {
      throw ApiError();
    }
  }
}
