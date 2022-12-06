// ignore_for_file: non_constant_identifier_names

class SearchModel {
  bool? status;
  String? message;
  SearchModelData? data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? SearchModelData.fromJson(json['data']) : null;
  }
}

class SearchModelData {
  int? current_page;
  List<SearchModelList> data = [];

  SearchModelData.fromJson(Map<String, dynamic> json) {
    current_page = json["current_page"];
    json["data"].forEach((element) {
      data.add(SearchModelList.fromJson(element));
    });
  }
}

class SearchModelList {
  int? id;
  String? name;
  dynamic price;
  String? image;
  String? description;
  bool? in_favorites;
  bool? in_cart;
  SearchModelList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    price = json["price"];
    image = json["image"];
    description = json["description"];
    in_favorites = json["in_favorites"];
    in_cart = json["in_cart"];
  }
}
