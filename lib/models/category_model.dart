// ignore_for_file: non_constant_identifier_names

class CategoryModel {
  bool? status;
  CategoryData? data;
  CategoryModel.formJson(Map<String, dynamic> json) {
    status = json["status"];
    data = json['data'] != null ? CategoryData.formJson(json['data']) : null;
  }
}

class CategoryData {
  int? current_page;
  List<CategoryDataList> data = [];
  CategoryData.formJson(Map<String, dynamic> json) {
    current_page = json["current_page"];
    json['data'].forEach((element) {
      data.add(CategoryDataList.formJson(element));
    });
  }
}

class CategoryDataList {
  int? id;
  String? name;
  String? image;
  CategoryDataList.formJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
