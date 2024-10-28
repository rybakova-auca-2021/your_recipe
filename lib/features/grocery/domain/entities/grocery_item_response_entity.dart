class GroceryItemResponseEntity {
  final int id;
  final int user;
  final String name;
  final int quantity;

  GroceryItemResponseEntity({
    required this.id,
    required this.user,
    required this.name,
    required this.quantity,
  });

  GroceryItemResponseEntity copyWith({
    int? id,
    String? name,
    int? quantity,
    String? user,
  }) {
    return GroceryItemResponseEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      user: this.user,
    );
  }
}
