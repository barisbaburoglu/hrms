class LoginResponseModel {
  String? tokenType;
  String? accessToken;
  int? expiresIn;
  String? refreshToken;
  String? reasonPhrase;
  String? hata;

  LoginResponseModel(
      {this.tokenType, this.accessToken, this.expiresIn, this.refreshToken});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    tokenType = json['tokenType'] ?? "";
    accessToken = json['accessToken'] ?? "";
    expiresIn = json['expiresIn'] ?? 0;
    refreshToken = json['refreshToken'] ?? "";
    reasonPhrase = json['reasonPhrase'] ?? "";
  }
}
