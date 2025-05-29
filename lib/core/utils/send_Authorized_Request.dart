import 'package:http/http.dart' as http;
import 'package:petsica/core/utils/taken_storage.dart';
import 'package:petsica/services/signup/token_refresher.dart';

// Future<http.Response> sendAuthorizedRequest({
//   required Uri url,
//   required String method,
//   Map<String, String>? headers,
//   Object? body,
// }) async {
//   String? token = await TokenStorage.getAccessToken();

//   headers ??= {};
//   headers['Authorization'] = 'Bearer $token';
//   headers['Content-Type'] = headers['Content-Type'] ?? 'application/json';

//   http.Response response;

//   // First attempt
//   if (method.toUpperCase() == 'POST') {
//     response = await http.post(url, headers: headers, body: body);
//   } else {
//     response = await http.get(url, headers: headers);
//   }

//   // If token is expired or unauthorized, try refreshing
//   if (response.statusCode == 401) {
//     final refreshed = await TokenRefresher.refreshToken();
//     if (refreshed) {
//       token = await TokenStorage.getAccessToken();
//       headers['Authorization'] = 'Bearer $token';

//       // Retry the request
//       if (method.toUpperCase() == 'POST') {
//         response = await http.post(url, headers: headers, body: body);
//       } else {
//         response = await http.get(url, headers: headers);
//       }
//     }
//   }

//   return response;
// }







Future<http.Response> sendAuthorizedRequest({
  required Uri url,
  required String method,
  Map<String, String>? headers,
  Object? body,
}) async {
  headers ??= {};
  method = method.toUpperCase();

  // Get the latest access token
  String? accessToken = await TokenStorage.getAccessToken();

  // Prepare headers with the current token
  Map<String, String> requestHeaders = {
    ...headers,
    'Authorization': 'Bearer $accessToken',
    'Content-Type': headers['Content-Type'] ?? 'application/json',
    'Accept': 'application/json',
  };

  // Initial request
  http.Response response = await _sendRequest(method, url, requestHeaders, body);

  // If unauthorized, try refreshing token and retrying
  if (response.statusCode == 401 && accessToken != null) {
    final refreshed = await TokenRefresher.refreshToken();

    if (refreshed) {
      final newAccessToken = await TokenStorage.getAccessToken();
      if (newAccessToken != null) {
        // Rebuild headers with new token
        requestHeaders = {
          ...headers,
          'Authorization': 'Bearer $newAccessToken',
          'Content-Type': headers['Content-Type'] ?? 'application/json',
          'Accept': 'application/json',
        };

        // Retry the request
        response = await _sendRequest(method, url, requestHeaders, body);
      }
    }
  }

  return response;
}

Future<http.Response> _sendRequest(
  String method,
  Uri url,
  Map<String, String> headers,
  Object? body,
) async {
  switch (method) {
    case 'POST':
      return await http.post(url, headers: headers, body: body);
    case 'PUT':
      return await http.put(url, headers: headers, body: body);
    case 'PATCH':
      return await http.patch(url, headers: headers, body: body);
    case 'DELETE':
      return await http.delete(url, headers: headers, body: body);
    case 'GET':
    default:
      return await http.get(url, headers: headers);
  }
}