class CategoryItemModel {
  String? name;
  String? iconUrl;

  CategoryItemModel({this.name, this.iconUrl});

  factory CategoryItemModel.fromJson(Map<String, dynamic> json) {
    return CategoryItemModel(
      name: json['nome'] as String?,
      iconUrl: json['icone'] as String?,
    );
  }
}
