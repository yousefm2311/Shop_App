class UpdateUserModel{
  bool? status;
  String? message;
  UserModelData? data;
  UpdateUserModel.fromJson(Map<String, dynamic> json){
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? UserModelData.fromJson(json["data"]) : null;
  }
}



class UserModelData {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? image;
  UserModelData.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    password = json["password"];
    image = json["image"];
  }
}
