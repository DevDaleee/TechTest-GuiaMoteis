class ItemModel {
  String? name;

  ItemModel({this.name});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      name: json['nome'] as String?,
    );
  }
}
