class LogInModel {
  String? email;
  String? password;
  String? twoFactorCode;
  String? twoFactorRecoveryCode;

  LogInModel({
    this.email,
    this.password,
    this.twoFactorCode,
    this.twoFactorRecoveryCode,
  });

  LogInModel.fromJson(Map<String, dynamic> mapOfJson)
      : email = mapOfJson["email"],
        password = mapOfJson["password"],
        twoFactorCode = mapOfJson["twoFactorCode"],
        twoFactorRecoveryCode = mapOfJson["twoFactorRecoveryCode"];

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'twoFactorCode': twoFactorCode,
        'twoFactorRecoveryCode': twoFactorRecoveryCode
      };
}
