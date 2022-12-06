class ChangePasswordModel {
  bool? status;
  String? message;
  ChangePasswordModelData? data;
  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null
        ? ChangePasswordModelData.fromJson(json['data'])
        : null;
  }
}

class ChangePasswordModelData {
  String? email;
  ChangePasswordModelData.fromJson(Map<String, dynamic> json) {
    email = json["email"];
  }
}
