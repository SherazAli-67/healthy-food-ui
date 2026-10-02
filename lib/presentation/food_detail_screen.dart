import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_food_ui/constants/number_constant.dart';
import 'package:healthy_food_ui/constants/string_const.dart';
import 'package:healthy_food_ui/core/app_colors.dart';
import 'package:healthy_food_ui/core/app_textstyles.dart';
import 'package:healthy_food_ui/core/asset_res.dart';
import 'package:healthy_food_ui/core/models/food_item.dart';
import 'package:healthy_food_ui/presentation/widgets/meal_type_badge.dart';

class FoodDetailScreen extends StatelessWidget {
  final FoodItem item;

  const FoodDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: .fromLTRB(
                NumberConstant.detailHorizontalPadding,
                NumberConstant.detailTopPadding,
                NumberConstant.detailHorizontalPadding,
                0,
              ),
              child: Column(
                spacing: NumberConstant.detailContentSpacing,
                children: [
                  _buildTopBar(context),
                  _buildHeroSection(),
                ],
              ),
            ),
          ),
          Expanded(child: _buildDetailsSheet()),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Stack(
      alignment: .center,
      children: [
        Align(
          alignment: .centerLeft,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Padding(
              padding: .symmetric(vertical: NumberConstant.detailTopPadding),
              child: SvgPicture.asset(AssetRes.icArrowBack),
            ),
          ),
        ),
        Text(item.heroLabel, style: AppTextStyles.detailHeroLabel),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Stack(
      alignment: .topCenter,
      children: [
        _buildOutlinedHeroTitle(),
        Padding(
          padding: .only(top: NumberConstant.detailHeroTitleToImageSpacing),
          child: Container(
            width: NumberConstant.detailHeroImageSize,
            height: NumberConstant.detailHeroImageSize,
            decoration: BoxDecoration(
              shape: .circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.cardShadowColor,
                  blurRadius: NumberConstant.detailHeroImageShadowBlur,
                  offset: Offset(0, NumberConstant.detailHeroImageShadowOffsetY),
                ),
              ],
              image: DecorationImage(image: AssetImage(item.image), fit: .cover),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOutlinedHeroTitle() {
    return Text(
      item.heroTitle.toUpperCase(),
      style: AppTextStyles.detailHeroOutline.copyWith(
        foreground: Paint()
          ..style = .stroke
          ..strokeWidth = NumberConstant.detailHeroOutlineStrokeWidth
          ..color = AppColors.blackColor,
      ),
    );
  }

  Widget _buildDetailsSheet() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: .vertical(top: .circular(NumberConstant.detailSheetRadius)),
        boxShadow: [
          BoxShadow(
            color: AppColors.sheetShadowColor,
            blurRadius: NumberConstant.detailSheetShadowBlur,
            offset: Offset(0, NumberConstant.detailSheetShadowOffsetY),
          ),
        ],
      ),
      padding: .fromLTRB(
        NumberConstant.detailSheetPadding,
        NumberConstant.detailSheetPadding,
        NumberConstant.detailSheetPadding,
        NumberConstant.detailSheetPadding,
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: NumberConstant.detailContentSpacing,
        children: [
          _buildTitleRow(),
          Text(item.description, style: AppTextStyles.detailDescription),
          Text(StringConst.readMore, style: AppTextStyles.readMore),
          _buildRatingRow(),
          _buildPricingCard(),
          const Spacer(),
          _buildPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildTitleRow() {
    return Row(
      spacing: NumberConstant.detailTitleRowSpacing,
      children: [
        Expanded(child: Text(item.title, style: AppTextStyles.detailTitle)),
        MealTypeBadge(label: item.mealType),
      ],
    );
  }

  Widget _buildRatingRow() {
    return Row(
      spacing: NumberConstant.detailRatingSpacing,
      children: [
        SvgPicture.asset(AssetRes.icRatingStars),
        Text(item.rating.toStringAsFixed(1), style: AppTextStyles.rating),
      ],
    );
  }

  Widget _buildPricingCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.primaryGreenColor,
        borderRadius: .circular(NumberConstant.pricingCardRadius),
      ),
      padding: .all(NumberConstant.pricingCardPadding),
      child: Column(
        spacing: NumberConstant.detailPricingSpacing,
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Expanded(child: Text(StringConst.deliveryAmount, style: AppTextStyles.deliveryAmountLabel)),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.deliveryChipColor,
                  borderRadius: .circular(NumberConstant.deliveryChipRadius),
                  border: .all(color: AppColors.whiteColor),
                ),
                padding: .symmetric(
                  horizontal: NumberConstant.deliveryChipHorizontalPadding,
                  vertical: NumberConstant.deliveryChipVerticalPadding,
                ),
                child: Text(
                  '${StringConst.dollarPrefix}${item.deliveryAmount.toStringAsFixed(2)}',
                  style: AppTextStyles.deliveryAmountValue,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(StringConst.totalAmount, style: AppTextStyles.totalAmountLabel),
              Text(
                '${StringConst.usdPrefix}${item.totalAmount.toStringAsFixed(2)}',
                style: AppTextStyles.totalAmountValue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.darkCharcoalColor,
        borderRadius: .circular(NumberConstant.paymentButtonRadius),
      ),
      padding: .all(NumberConstant.paymentButtonPadding),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: .symmetric(horizontal: NumberConstant.paymentButtonPadding),
              child: Text(StringConst.makePayment, style: AppTextStyles.paymentCta),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: .circular(NumberConstant.paymentArrowChipRadius),
            ),
            padding: .symmetric(
              horizontal: NumberConstant.paymentArrowChipHorizontalPadding,
              vertical: NumberConstant.paymentArrowChipVerticalPadding,
            ),
            child: SvgPicture.asset(
              AssetRes.icArrowNext,
              colorFilter: .mode(AppColors.blackColor, .srcIn),
            ),
          ),
        ],
      ),
    );
  }
}
