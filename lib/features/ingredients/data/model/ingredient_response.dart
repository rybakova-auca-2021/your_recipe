class IngredientResponse {
  final int? id;
  final int? user;
  final String name;
  final int? quantity;
  final String? manufactureDate;
  final String? expirationDate;
  final String category;

  IngredientResponse({
    required this.id,
    required this.user,
    required this.name,
    required this.quantity,
    required this.manufactureDate,
    required this.expirationDate,
    required this.category
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'name': name,
      'quantity': quantity,
      'date_of_manufacture': manufactureDate,
      'date_of_expiration': expirationDate,
      'category': category,
    };
  }

  factory IngredientResponse.fromJson(Map<String, dynamic> json) {
    return IngredientResponse(
      id: json['id'],
      user: json['user'],
      name: json['name'],
      quantity: json['quantity'],
      manufactureDate: json['date_of_manufacture'],
      expirationDate: json['date_of_expiration'],
      category: json['category'],
    );
  }
}