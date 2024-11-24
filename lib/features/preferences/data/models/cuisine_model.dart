class CuisineModel {
  final int id;
  final String name;

  CuisineModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory CuisineModel.fromJson(Map<String, dynamic> json) {
    return CuisineModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
