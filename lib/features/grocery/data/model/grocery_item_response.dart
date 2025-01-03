class GroceryItemResponse {
  final int id;
  final int user;
  final String name;
  final int quantity;
  final bool purchased;

  GroceryItemResponse({
    required this.id,
    required this.user,
    required this.name,
    required this.quantity,
    required this.purchased
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'name': name,
      'quantity': quantity,
      'purchased': purchased
    };
  }

  factory GroceryItemResponse.fromJson(Map<String, dynamic> json) {
    return GroceryItemResponse(
      id: json['id'],
      user: json['user'],
      name: json['name'],
      quantity: json['quantity'],
      purchased: json['purchased']
    );
  }
}
