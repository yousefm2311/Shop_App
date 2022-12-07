class CartModlePost {
  bool? status;
  String? message;
  CartData? data;
  CartModlePost.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? CartData.fromJson(json['data']):null;
  }
}

class CartData {
  int? id;
  int? quantity;
  ProductDataCart? product;
  CartData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    quantity = json["quantity"];
    product = json["product"] != null
        ? ProductDataCart.fromJson(json["product"])
        : null;
  }
}

class ProductDataCart {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;
  ProductDataCart.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    old_price = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    description = json["description"];
  }
}
