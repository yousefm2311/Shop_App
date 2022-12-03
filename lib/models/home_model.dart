// ignore_for_file: non_constant_identifier_names, camel_case_types
class Home_Model {
  bool? status;
  HomeDataModel? data;
  Home_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeDataModel.fromJson(json['data']) : null;
  }
}

class HomeDataModel {
  List<BannersData> banners = [];
  List<ProductData> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannersData.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductData.fromJson(element));
    });
  }
}

class BannersData {
  int? id;
  String? image;
  BannersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductData {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;
  ProductData.fromJson(Map<String, dynamic> json) {
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
