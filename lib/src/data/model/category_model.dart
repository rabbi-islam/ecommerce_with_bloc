class CategoryModel {
  String? title;
  List<String>? products;

  CategoryModel({this.title, this.products});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    products = json['products'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['products'] = this.products;
    return data;
  }
}
