class FoodItem {
  final String id;
  final String title;
  final String subtitle;
  final String mealType;
  final int kcal;
  final String image;
  final String heroLabel;
  final String heroTitle;
  final String description;
  final double rating;
  final double deliveryAmount;
  final double totalAmount;

  const FoodItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.mealType,
    required this.kcal,
    required this.image,
    required this.heroLabel,
    required this.heroTitle,
    required this.description,
    required this.rating,
    required this.deliveryAmount,
    required this.totalAmount,
  });
}
