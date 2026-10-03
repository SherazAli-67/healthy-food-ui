import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_food_ui/constants/number_constant.dart';
import 'package:healthy_food_ui/constants/string_const.dart';
import 'package:healthy_food_ui/core/app_colors.dart';
import 'package:healthy_food_ui/core/app_data.dart';
import 'package:healthy_food_ui/core/app_textstyles.dart';
import 'package:healthy_food_ui/core/asset_res.dart';
import 'package:healthy_food_ui/core/models/food_category.dart';
import 'package:healthy_food_ui/core/models/food_item.dart';
import 'package:healthy_food_ui/presentation/widgets/meal_type_badge.dart';
import 'package:healthy_food_ui/routing/router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: .fromLTRB(NumberConstant.horizontalPadding, NumberConstant.homeTopPadding, NumberConstant.horizontalPadding, 0),
          child: Column(
            spacing: NumberConstant.homeSectionSpacing,
            children: [
              Column(
                spacing: NumberConstant.homeHeaderToSearchSpacing,
                children: [
                  _buildHeader(),
                  Column(
                    spacing: NumberConstant.homeSearchToCategorySpacing,
                    children: [
                      _buildSearchRow(),
                      _buildCategorySection(),
                    ],
                  ),
                ],
              ),
              Expanded(child: _buildFoodList(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      spacing: NumberConstant.homeHeaderRowSpacing,
      children: [
        ClipOval(
          //profileAvatar, height-width:avatarSize
          child: Image.asset(AssetRes.profileAvatar, height: NumberConstant.avatarSize,)
        ),

        //helloSheraz, greeting
        Text(StringConst.helloSheraz, style: AppTextStyles.greeting,),
        //waveEmoji, greeting
        Text(StringConst.waveEmoji, style: AppTextStyles.greeting,),
        const Spacer(),
        //icDrawerMenu
        SvgPicture.asset(AssetRes.icDrawerMenu)
      ],
    );
  }

  Widget _buildSearchRow() {
    return Row(
      spacing: NumberConstant.searchRowSpacing,
      children: [
        Expanded(
          child: Container(
            height: NumberConstant.searchFieldHeight,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: .circular(NumberConstant.searchFieldRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.searchShadowColor,
                  blurRadius: NumberConstant.searchShadowBlur,
                  offset: Offset(0, NumberConstant.searchShadowOffsetY),
                ),
              ],
            ),
            alignment: .centerLeft,
            padding: .symmetric(horizontal: NumberConstant.foodCardPadding),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: .zero,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            // color: AppColors.primaryGreenColor,
            // borderRadius: .circular(NumberConstant.searchButtonRadius),
            color: AppColors.primaryGreenColor, 
            borderRadius: .circular(NumberConstant.searchButtonRadius)
          ),
          padding: .symmetric(
            horizontal: NumberConstant.searchButtonHorizontalPadding,
            vertical: NumberConstant.searchButtonVerticalPadding,
          ),
          //icSearch
          child: SvgPicture.asset(AssetRes.icDrawerMenu)
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      spacing: NumberConstant.categorySectionSpacing,
      crossAxisAlignment: .start,
      children: [
        //foodCategory, sectionTitle
        Text(StringConst.foodCategory, style: AppTextStyles.sectionTitle,),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: AppData.categories.map(_buildCategoryItem).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(FoodCategory category) {
    return Column(
      spacing: NumberConstant.categoryLabelSpacing,
      children: [
        Container(
          // width: NumberConstant.categorySize,
          // height: NumberConstant.categorySize,
          width: NumberConstant.categorySize,
          height: NumberConstant.categorySize,
          decoration: BoxDecoration(
            shape: .circle,
            border: .all(color: AppColors.primaryGreenColor, width: NumberConstant.categoryBorderWidth),
          ),
          alignment: .center,
          child: ClipOval(

            //category.image, width-height: categoryImageSize
            child: Image.asset(category.image, height: NumberConstant.categoryImageSize,)
          ),
        ),
        //category.name, categoryLabel
        Text(category.name, style: AppTextStyles.categoryLabel,)
      ],
    );
  }

  Widget _buildFoodList(BuildContext context) {
    return SingleChildScrollView(
      padding: .only(top: NumberConstant.foodCardImageOverlap, bottom: NumberConstant.homeBottomPadding),
      child: Column(
        spacing: NumberConstant.foodCardListSpacing,
        children: AppData.foodItems.map((item) => _buildFoodCard(context, item)).toList(),
      ),
    );
  }

  Widget _buildFoodCard(BuildContext context, FoodItem item) {
    return GestureDetector(
      onTap: () => context.push(NamedRoutes.foodDetail.routeName, extra: item),
      child: SizedBox(
        height: NumberConstant.foodCardHeight,
        child: Stack(
          clipBehavior: .none,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: .circular(NumberConstant.foodCardRadius),
                  border: .all(color: AppColors.primaryGreenColor, width: NumberConstant.foodCardBorderWidth),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cardShadowColor.withValues(alpha: 0.1),
                      blurRadius: NumberConstant.foodCardShadowBlur,
                      offset: Offset(0, NumberConstant.foodCardShadowOffsetY),
                    ),
                  ],
                ),
                padding: .all(NumberConstant.foodCardPadding),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    //MealTypeBadge: item.mealType
                    MealTypeBadge(label: item.mealType),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: .end,
                      children: [
                        Expanded(
                          child: Column(
                            spacing: NumberConstant.foodCardContentSpacing,
                            crossAxisAlignment: .start,
                            children: [
                              //item.title, foodCardTitle,
                              Text(item.title, style: AppTextStyles.foodCardTitle,),
                              //item.subtitle, foodCardSubtitle
                              Text(item.subtitle, style: AppTextStyles.foodCardSubtitle,)
                             ],
                          ),
                        ),
                        Row(
                          mainAxisSize: .min,
                          spacing: NumberConstant.kcalRowSpacing,
                          crossAxisAlignment: .end,
                          children: [
                            //icCalories
                            SvgPicture.asset(AssetRes.icCalories),
                            //, kcalLabel
                            Text('${item.kcal} ${StringConst.kcalUnit}', style: AppTextStyles.kcalLabel,)
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: -NumberConstant.foodCardImageOverlap,
              right: 0,
              child: Container(
                width: NumberConstant.foodCardImageSize,
                height: NumberConstant.foodCardImageSize,
                decoration: BoxDecoration(
                  shape: .circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.foodImageShadowColor.withValues(alpha: 0.1),
                      blurRadius: NumberConstant.foodCardShadowBlur,
                      offset: Offset(0, NumberConstant.foodCardShadowOffsetY),
                    ),
                  ],

                  image: DecorationImage(image: AssetImage(item.image), fit: .cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
