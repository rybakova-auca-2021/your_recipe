import '../../domain/entity/recipe_entity.dart';

class PopularRecipe {
  final int id;
  final String name;
  final String numberOfPeople;
  final String time;
  final String imageUrl;

  PopularRecipe({
    required this.id,
    required this.name,
    required this.numberOfPeople,
    required this.time,
    required this.imageUrl,
  });

  factory PopularRecipe.fromJson(Map<String, dynamic> json) {
    return PopularRecipe(
      id: json['id'],
      name: json['name'],
      numberOfPeople: json['number_of_people'],
      time: json['time'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'number_of_people': numberOfPeople,
      'time': time,
      'image_url': imageUrl,
    };
  }

  PopularRecipeEntity toEntity() {
    return PopularRecipeEntity(
      id: id,
      name: name,
      time: time,
      numberOfPeople: numberOfPeople,
      imageUrl: imageUrl
    );
  }
}
