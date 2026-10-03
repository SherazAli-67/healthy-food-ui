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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  String? _pressedFoodId;
  int? _selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: NumberConstant.animHomeMs));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _fade(double begin, double end) =>
      CurvedAnimation(parent: _controller, curve: Interval(begin, end, curve: Curves.easeOut));

  Animation<double> _slide(double begin, double end) =>
      Tween(begin: NumberConstant.animHomeSlideY, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Interval(begin, end, curve: Curves.easeOutCubic)),);

  Widget _staggeredEntrance({required double begin, required double end, required Widget child}) {
    final fade = _fade(begin, end);
    final slide = _slide(begin, end);
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: fade.value,
        child: Transform.translate(offset: Offset(0, slide.value), child: child),
      ),
      child: child,
    );
  }

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
                  _staggeredEntrance(begin: 0, end: 0.25, child: _buildHeader()),
                  Column(
                    spacing: NumberConstant.homeSearchToCategorySpacing,
                    children: [
                      _staggeredEntrance(begin: 0.1, end: 0.35, child: _buildSearchRow()),
                      _staggeredEntrance(begin: 0.2, end: 0.5, child: _buildCategorySection()),
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
        ClipOval(child: Image.asset(AssetRes.profileAvatar, height: NumberConstant.avatarSize)),
        Text(StringConst.helloSheraz, style: AppTextStyles.greeting),
        Text(StringConst.waveEmoji, style: AppTextStyles.greeting),
        const Spacer(),
        SvgPicture.asset(AssetRes.icDrawerMenu),
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
              decoration: InputDecoration(border: InputBorder.none, isDense: true, contentPadding: .zero),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.primaryGreenColor,
            borderRadius: .circular(NumberConstant.searchButtonRadius),
          ),
          padding: .symmetric(
            horizontal: NumberConstant.searchButtonHorizontalPadding,
            vertical: NumberConstant.searchButtonVerticalPadding,
          ),
          child: SvgPicture.asset(AssetRes.icDrawerMenu),
        ),
      ],
    );
  }

  Widget _buildCategorySection() {
    return Column(
      spacing: NumberConstant.categorySectionSpacing,
      crossAxisAlignment: .start,
      children: [
        Text(StringConst.foodCategory, style: AppTextStyles.sectionTitle),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            for (var i = 0; i < AppData.categories.length; i++) _buildCategoryItem(AppData.categories[i], i),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryItem(FoodCategory category, int index) {
    final begin = (0.25 + index * 0.05).clamp(0.0, 0.85);
    final end = (begin + 0.2).clamp(0.0, 1.0);
    final scale = Tween(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(begin, end, curve: Curves.easeOutBack)),
    );
    final selected = _selectedCategoryIndex == index;
    return AnimatedBuilder(
      animation: scale,
      builder: (context, child) => Transform.scale(scale: scale.value, child: child),
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategoryIndex = index),
        child: AnimatedScale(
          scale: selected ? NumberConstant.animCategorySelectedScale : 1.0,
          duration: Duration(milliseconds: NumberConstant.animPressMs),
          curve: Curves.easeOut,
          child: Column(
            spacing: NumberConstant.categoryLabelSpacing,
            children: [
              Container(
                width: NumberConstant.categorySize,
                height: NumberConstant.categorySize,
                decoration: BoxDecoration(
                  shape: .circle,
                  border: .all(color: AppColors.primaryGreenColor, width: NumberConstant.categoryBorderWidth),
                ),
                alignment: .center,
                child: ClipOval(child: Image.asset(category.image, height: NumberConstant.categoryImageSize)),
              ),
              Text(category.name, style: AppTextStyles.categoryLabel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFoodList(BuildContext context) {
    return SingleChildScrollView(
      padding: .only(top: NumberConstant.foodCardImageOverlap, bottom: NumberConstant.homeBottomPadding),
      child: Column(
        spacing: NumberConstant.foodCardListSpacing,
        children: [
          for (var i = 0; i < AppData.foodItems.length; i++)
            _staggeredEntrance(
              begin: (0.35 + i * NumberConstant.animHomeCardStagger).clamp(0.0, 0.85),
              end: 1.0,
              child: _buildFoodCard(context, AppData.foodItems[i]),
            ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(BuildContext context, FoodItem item) {
    final pressed = _pressedFoodId == item.id;
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressedFoodId = item.id),
      onTapCancel: () => setState(() => _pressedFoodId = null),
      onTapUp: (_) {
        setState(() => _pressedFoodId = null);
        context.push(NamedRoutes.foodDetail.routeName, extra: item);
      },
      child: AnimatedScale(
        scale: pressed ? NumberConstant.animCardPressScale : 1.0,
        duration: Duration(milliseconds: NumberConstant.animPressMs),
        curve: Curves.easeOut,
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
                                Text(item.title, style: AppTextStyles.foodCardTitle),
                                Text(item.subtitle, style: AppTextStyles.foodCardSubtitle),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: .min,
                            spacing: NumberConstant.kcalRowSpacing,
                            crossAxisAlignment: .end,
                            children: [
                              SvgPicture.asset(AssetRes.icCalories),
                              Text('${item.kcal} ${StringConst.kcalUnit}', style: AppTextStyles.kcalLabel),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -NumberConstant.foodCardImageOverlap,
                right: 0,
                child: Hero(
                  tag: 'food-image-${item.id}',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
