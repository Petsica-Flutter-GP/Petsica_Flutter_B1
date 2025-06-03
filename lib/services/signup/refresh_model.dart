class RefreshResponse {
  final String token;
  final String refreshToken;

  RefreshResponse({required this.token, required this.refreshToken});

  factory RefreshResponse.fromJson(Map<String, dynamic> json) {
    return RefreshResponse(
      token: json['accessToken'] ?? json['token'],
      refreshToken: json['refreshToken'],
    );
  }
}
