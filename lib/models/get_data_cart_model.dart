class GetDataCartModel {
  bool? status;
  String? message;
  GetDataFromList? data;
  GetDataCartModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? GetDataFromList.fromJson(json["data"]) : null;
  }
}

class GetDataFromList {
  List<CartItemModel> cart_items = [];
  dynamic sub_total;
  dynamic total;
  GetDataFromList.fromJson(Map<String, dynamic> json) {
    json['cart_items'].forEach((element) {
      cart_items.add(CartItemModel.fromJson(element));
    });
    sub_total = json['sub_total'];
    total = json['total'];
  }
}

class CartItemModel {
  int? id;
  int? quantity;
  CartProductData? product;
  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product = json['product'] != null
        ? CartProductData.fromJson(json['product'])
        : null;
  }
}

class CartProductData {
  int? id;
  dynamic price;
  dynamic old_price;
  int? discount;
  String? image;
  String? name;
  String? description;
  bool? in_favorites;
  bool? in_cart;
  CartProductData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    old_price = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    description = json["description"];
    in_favorites = json["in_favorites"];
    in_cart = json["in_cart"];
  }
}
