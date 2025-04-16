class RefreshTokenRequest {
  final String token;
  final String refreshToken;

  RefreshTokenRequest({required this.token, required this.refreshToken});

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
    };
  }
}
