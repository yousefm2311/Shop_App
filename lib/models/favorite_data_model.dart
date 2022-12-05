// ignore_for_file: non_constant_identifier_names

class FavoriteModel {
  bool? status;
  FavoriteDataModel? data;
  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    data =
        json['data'] != null ? FavoriteDataModel.fromJson(json["data"]) : null;
  }
}

class FavoriteDataModel {
  int? current_page;
  List<FavoriteDataList> data = [];
  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    current_page = json["current_page"];
    json['data'].forEach((element) {
      data.add(FavoriteDataList.fromJson(element));
    });
  }
}

class FavoriteDataList {
  int? id;
  FavoriteProductModel? product;
  FavoriteDataList.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    product = json["product"] != null
        ? FavoriteProductModel.fromJson(json["product"])
        : null;
  }
}

class FavoriteProductModel {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;
  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
