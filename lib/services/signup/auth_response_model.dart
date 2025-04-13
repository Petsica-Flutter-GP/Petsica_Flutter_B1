// models/login_response.dart
class LoginResponse {
  final String id;
  final String email;
  final String token;
  final int expiresIn;
  final String refreshToken;
  final DateTime refreshTokenExpiration;

  LoginResponse({
    required this.id,
    required this.email,
    required this.token,
    required this.expiresIn,
    required this.refreshToken,
    required this.refreshTokenExpiration,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      email: json['email'],
      token: json['token'],
      expiresIn: json['expiresIn'],
      refreshToken: json['refreshToken'],
      refreshTokenExpiration: DateTime.parse(json['refreshTokenExpiration']),
    );
  }
}
