import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_food_ui/constants/number_constant.dart';
import 'package:healthy_food_ui/constants/string_const.dart';
import 'package:healthy_food_ui/core/app_colors.dart';
import 'package:healthy_food_ui/core/app_textstyles.dart';
import 'package:healthy_food_ui/core/asset_res.dart';
import 'package:healthy_food_ui/routing/router.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkCharcoalColor,
      body: Column(
        children: [
          Expanded(
            flex: NumberConstant.onboardingImageFlex,
            child: Image.asset(AssetRes.onboardingImg, fit: .cover, width: double.infinity,),
          ),
          Expanded(
            flex: NumberConstant.onboardingContentFlex,
            child: Padding(
              padding: .fromLTRB(
                NumberConstant.horizontalPadding,
                0,
                NumberConstant.horizontalPadding,
                NumberConstant.onboardingBottomPadding,
              ),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  _buildHeadline(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    crossAxisAlignment: .center,
                    children: [
                      _buildPageIndicator(),
                      _buildNextCta(context),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline() {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: StringConst.eat, style: AppTextStyles.onboardingHeroAccent),
          TextSpan(text: StringConst.wellComma, style: AppTextStyles.onboardingHero),
          TextSpan(text: StringConst.feel, style: AppTextStyles.onboardingHeroAccent),
          TextSpan(text: StringConst.wellComma, style: AppTextStyles.onboardingHero),
          TextSpan(text: StringConst.live, style: AppTextStyles.onboardingHeroAccent),
          TextSpan(text: StringConst.wellPeriod, style: AppTextStyles.onboardingHero),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      spacing: NumberConstant.onboardingIndicatorSpacing,
      children: [
        _buildIndicatorDot(),
        _buildIndicatorDot(),
        _buildIndicatorActive(),
      ],
    );
  }

  Widget _buildIndicatorDot() {
    return Container(
      width: NumberConstant.onboardingIndicatorInactiveSize,
      height: NumberConstant.onboardingIndicatorInactiveSize,
      decoration: BoxDecoration(color: AppColors.indicatorInactiveColor, shape: .circle),
    );
  }

  Widget _buildIndicatorActive() {
    return Container(
      width: NumberConstant.onboardingIndicatorActiveWidth,
      height: NumberConstant.onboardingIndicatorHeight,
      decoration: BoxDecoration(
        color: AppColors.primaryGreenColor,
        borderRadius: .circular(NumberConstant.onboardingIndicatorHeight),
      ),
    );
  }

  Widget _buildNextCta(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(NamedRoutes.home.routeName),
      child: Container(
        decoration: BoxDecoration(
          shape: .circle,
          border: .all(color: AppColors.whiteColor, width: NumberConstant.onboardingCtaBorderWidth),
        ),
        padding: .symmetric(
          horizontal: NumberConstant.onboardingCtaHorizontalPadding,
          vertical: NumberConstant.onboardingCtaVerticalPadding,
        ),
        child: SvgPicture.asset(AssetRes.icArrowNext),
      ),
    );
  }
}
