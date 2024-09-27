class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String area;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.area,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
      area: json['strArea'] ?? 'Unknown',
    );
  }

  get price => null;
}
