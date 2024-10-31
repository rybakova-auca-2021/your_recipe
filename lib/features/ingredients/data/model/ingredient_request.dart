class IngredientRequest {
  final String name;
  final String? quantity;
  final String? manufactureDate;
  final String? expirationDate;
  final String category;

  IngredientRequest({
    required this.name,
    required this.quantity,
    this.manufactureDate,
    this.expirationDate,
    required this.category
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'date_of_manufacture': manufactureDate,
      'date_of_expiration': expirationDate,
      'category': category,
    };
  }

  factory IngredientRequest.fromJson(Map<String, dynamic> json) {
    return IngredientRequest(
      name: json['name'],
      quantity: json['quantity'],
      manufactureDate: json['date_of_manufacture'],
      expirationDate: json['date_of_expiration'],
      category: json['category'],
    );
  }
}