import 'package:flutter/material.dart';
import 'package:healthy_food_ui/constants/number_constant.dart';
import 'package:healthy_food_ui/core/app_colors.dart';
import 'package:healthy_food_ui/core/app_textstyles.dart';

class MealTypeBadge extends StatelessWidget {
  final String label;

  const MealTypeBadge({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryGreenColor,
        borderRadius: .circular(NumberConstant.mealBadgeRadius),
      ),
      padding: .symmetric(
        horizontal: NumberConstant.mealBadgeHorizontalPadding,
        vertical: NumberConstant.mealBadgeVerticalPadding,
      ),
      child: Text(label, style: AppTextStyles.mealBadge),
    );
  }
}
