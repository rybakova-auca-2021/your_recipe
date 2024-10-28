class GroceryItemResponse {
  final int id;
  final int user;
  final String name;
  final int quantity;

  GroceryItemResponse({
    required this.id,
    required this.user,
    required this.name,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'name': name,
      'quantity': quantity,
    };
  }

  factory GroceryItemResponse.fromJson(Map<String, dynamic> json) {
    return GroceryItemResponse(
      id: json['id'],
      user: json['user'],
      name: json['name'],
      quantity: json['quantity'],
    );
  }
}
