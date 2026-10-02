import 'package:healthy_food_ui/constants/string_const.dart';
import 'package:healthy_food_ui/core/asset_res.dart';
import 'package:healthy_food_ui/core/models/food_category.dart';
import 'package:healthy_food_ui/core/models/food_item.dart';

class AppData {
  static const categories = [
    FoodCategory(name: StringConst.vegetables, image: AssetRes.vegetablesCategory),
    FoodCategory(name: StringConst.nutsAndSeeds, image: AssetRes.nutsSeedsCategory),
    FoodCategory(name: StringConst.protein, image: AssetRes.proteinCategory),
    FoodCategory(name: StringConst.proteinShakes, image: AssetRes.proteinShakesCategory),
  ];

  static const foodItems = [
    FoodItem(
      id: 'french_green_salad',
      title: StringConst.frenchGreenSalad,
      subtitle: StringConst.foodCardSubtitle,
      mealType: StringConst.breakfast,
      kcal: 125,
      image: AssetRes.frenchGreenSaladImg,
      heroLabel: StringConst.french,
      heroTitle: StringConst.greenSalad,
      description: StringConst.detailDescription,
      rating: 4.0,
      deliveryAmount: 3.88,
      totalAmount: 38.00,
    ),
    FoodItem(
      id: 'green_veggies_lunch',
      title: StringConst.greenVeggies,
      subtitle: StringConst.foodCardSubtitle,
      mealType: StringConst.lunch,
      kcal: 115,
      image: AssetRes.greenVeggiesImg,
      heroLabel: StringConst.french,
      heroTitle: StringConst.greenSalad,
      description: StringConst.detailDescription,
      rating: 4.0,
      deliveryAmount: 3.88,
      totalAmount: 32.00,
    ),
    FoodItem(
      id: 'green_veggies_dinner',
      title: StringConst.greenVeggies,
      subtitle: StringConst.foodCardSubtitle,
      mealType: StringConst.dinner,
      kcal: 115,
      image: AssetRes.greenFood2Img,
      heroLabel: StringConst.french,
      heroTitle: StringConst.greenSalad,
      description: StringConst.detailDescription,
      rating: 4.0,
      deliveryAmount: 3.88,
      totalAmount: 32.00,
    ),
  ];
}
