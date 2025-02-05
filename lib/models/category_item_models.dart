class CategoryItemModels {
  String? name;
  String? iconUrl;

  CategoryItemModels({
    this.name,
    this.iconUrl,
  });

  factory CategoryItemModels.fromJson(Map<String, dynamic> json) {
    return CategoryItemModels(
      name: json['nome'] as String?,
      iconUrl: json['icone'] as String?,
    );
  }
}
