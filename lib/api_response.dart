class ApiResponse<T extends AppDataModel> {
  String? message;
  int? statusCode;
  T? data;

  ApiResponse({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  ApiResponse.fromJson(Map<String, dynamic> json, T myData) {
    message = json["message"];
    statusCode = json["statusCode"];
    data = myData;
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "statusCode": statusCode,
      "data": data?.toJson(),
    };
  }
}

abstract class AppDataModel {
  Map<String, dynamic> toJson();
}

class AppUserModel extends AppDataModel {
  int? id;
  String? email;
  String? phone;
  String? password;
  String? accessToken;

  AppUserModel({
    this.id,
    this.email,
    this.phone,
    this.password,
    this.accessToken,
  });

  AppUserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    email = json["email"];
    phone = json["phone"];
    password = json["password"];
    accessToken = json["accessToken"];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "phone": phone,
      "password": password,
      "accessToken": accessToken,
    };
  }
}
