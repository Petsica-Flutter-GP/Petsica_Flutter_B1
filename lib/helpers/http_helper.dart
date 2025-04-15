import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/services/signup/token_refresher.dart';

Future<http.Response> sendAuthorizedRequest({
  required Uri url,
  required String method,
  Map<String, String>? headers,
  Object? body,
}) async {
  String? token = await TokenStorage.getAccessToken();

  headers ??= {};
  headers['Authorization'] = 'Bearer $token';
  headers['Content-Type'] = headers['Content-Type'] ?? 'application/json';

  http.Response response;

  // First attempt
  if (method.toUpperCase() == 'POST') {
    response = await http.post(url, headers: headers, body: body);
  } else {
    response = await http.get(url, headers: headers);
  }

  // If token is expired or unauthorized, try refreshing
  if (response.statusCode == 401) {
    final refreshed = await TokenRefresher.refreshToken();
    if (refreshed) {
      token = await TokenStorage.getAccessToken();
      headers['Authorization'] = 'Bearer $token';

      // Retry the request
      if (method.toUpperCase() == 'POST') {
        response = await http.post(url, headers: headers, body: body);
      } else {
        response = await http.get(url, headers: headers);
      }
    }
  }

  return response;
}