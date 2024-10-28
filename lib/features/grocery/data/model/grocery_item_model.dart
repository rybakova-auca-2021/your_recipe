class GroceryItemModel {
  final String name;
  final String? quantity;

  GroceryItemModel({
    required this.name,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
    };
  }

  factory GroceryItemModel.fromJson(Map<String, dynamic> json) {
    return GroceryItemModel(
        name: json['name'],
        quantity: json['quantity'],
    );
  }
}