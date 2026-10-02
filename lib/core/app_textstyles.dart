import 'package:flutter/material.dart';
import 'package:healthy_food_ui/constants/string_const.dart';
import 'package:healthy_food_ui/core/app_colors.dart';

class AppTextStyles {
  static const onboardingHero = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 60,
    color: AppColors.whiteColor,
    height: 1.35,
  );

  static const onboardingHeroAccent = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 60,
    color: AppColors.primaryGreenColor,
    height: 1.35,
  );

  static const greeting = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 22,
    color: AppColors.blackColor,
  );

  static const sectionTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 20,
    color: AppColors.blackColor,
  );

  static const categoryLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 14,
    color: AppColors.blackColor,
  );

  static const foodCardTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 20,
    color: AppColors.blackColor,
  );

  static const foodCardSubtitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 14,
    color: AppColors.secondaryGrayColor,
  );

  static const mealBadge = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.blackColor,
  );

  static const kcalLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.blackColor,
  );

  static const detailHeroLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 28,
    color: AppColors.primaryGreenColor,
    letterSpacing: 1.68,
  );

  static const detailHeroOutline = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 44,
    color: AppColors.blackColor,
    letterSpacing: 2.64,
  );

  static const detailTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 26,
    color: AppColors.blackColor,
  );

  static const detailDescription = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.textSecondaryColor,
  );

  static const readMore = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 16,
    color: AppColors.textTertiaryColor,
    decoration: TextDecoration.underline,
  );

  static const rating = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 14,
    color: AppColors.textSecondaryColor,
  );

  static const deliveryAmountLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 20,
    color: AppColors.blackColor,
  );

  static const deliveryAmountValue = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 16,
    color: AppColors.blackColor,
  );

  static const totalAmountLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 14,
    color: AppColors.textSecondaryColor,
  );

  static const totalAmountValue = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w700,
    fontSize: 26,
    color: AppColors.blackColor,
  );

  static const paymentCta = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 21,
    color: AppColors.whiteColor,
  );
}
