class FavoritePostModel {
  bool? status;
  String? message;
  FavoritePostModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
