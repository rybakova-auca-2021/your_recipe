class Ingredient {
  final int? id;
  final int? user;
  final String name;
  final String? quantity;
  final String? manufactureDate;
  final String? expirationDate;
  final String category;

  Ingredient({
    this.id,
    this.user,
    required this.name,
    required this.quantity,
    this.manufactureDate,
    this.expirationDate,
    required this.category,
  });
}