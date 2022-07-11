abstract class ApiClient {
  Future<Map<String, dynamic>> get({required String path});
  Future<Map<String, dynamic>> post({required String path, required Map<String, dynamic>body});
}