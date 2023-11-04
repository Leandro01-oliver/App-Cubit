
class ProdutividadeModel {
  final int? id;
  final String? description;

  ProdutividadeModel({this.id, this.description});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
    };
  }

    factory ProdutividadeModel.fromJson(Map<String, dynamic> json) {
    return ProdutividadeModel(
      id: json['id'],
      description: json['description'],
    );
}
}
