import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:healthy_food_ui/constants/number_constant.dart';
import 'package:healthy_food_ui/constants/string_const.dart';
import 'package:healthy_food_ui/core/app_colors.dart';
import 'package:healthy_food_ui/core/app_textstyles.dart';
import 'package:healthy_food_ui/core/asset_res.dart';
import 'package:healthy_food_ui/routing/router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _imageFade;
  late final Animation<double> _imageScale;
  late final Animation<double> _headlineFade;
  late final Animation<double> _headlineSlide;
  late final Animation<double> _indicatorFade;
  late final Animation<double> _indicatorWidth;
  late final Animation<double> _ctaScale;
  bool _ctaPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: NumberConstant.animOnboardingMs));
    _imageFade = CurvedAnimation(parent: _controller, curve: Interval(0, 0.45, curve: Curves.easeOut));
    _imageScale = Tween(begin: NumberConstant.animOnboardingImageScaleBegin, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0, 0.5, curve: Curves.easeOutCubic)),
    );
    _headlineFade = CurvedAnimation(parent: _controller, curve: Interval(0.15, 0.55, curve: Curves.easeOut));
    _headlineSlide = Tween(begin: NumberConstant.animOnboardingSlideY, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.15, 0.55, curve: Curves.easeOutCubic)),
    );
    _indicatorFade = CurvedAnimation(parent: _controller, curve: Interval(0.4, 0.75, curve: Curves.easeOut));
    _indicatorWidth = Tween(
      begin: NumberConstant.onboardingIndicatorInactiveSize,
      end: NumberConstant.onboardingIndicatorActiveWidth,
    ).animate(CurvedAnimation(parent: _controller, curve: Interval(0.4, 0.75, curve: Curves.easeOutCubic)));
    _ctaScale = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.elasticOut)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onNextTap() async {
    setState(() => _ctaPressed = true);
    await Future.delayed(Duration(milliseconds: NumberConstant.animPressMs));
    if (!mounted) return;
    context.go(NamedRoutes.home.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkCharcoalColor,
      body: Column(
        children: [
          Expanded(flex: NumberConstant.onboardingImageFlex, child: _buildHeroImage()),
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
                  _buildAnimatedHeadline(),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    crossAxisAlignment: .center,
                    children: [
                      _buildPageIndicator(),
                      _buildNextCta(),
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

  Widget _buildHeroImage() {
    return FadeTransition(
      opacity: _imageFade,
      child: ScaleTransition(
        scale: _imageScale,
        child: Image.asset(AssetRes.onboardingImg, fit: .cover, width: double.infinity),
      ),
    );
  }

  Widget _buildAnimatedHeadline() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _headlineFade.value,
        child: Transform.translate(offset: Offset(0, _headlineSlide.value), child: child),
      ),
      child: _buildHeadline(),
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
    return FadeTransition(
      opacity: _indicatorFade,
      child: Row(
        spacing: NumberConstant.onboardingIndicatorSpacing,
        children: [
          _buildIndicatorDot(),
          _buildIndicatorDot(),
          _buildIndicatorActive(),
        ],
      ),
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
    return AnimatedBuilder(
      animation: _indicatorWidth,
      builder: (context, _) => Container(
        width: _indicatorWidth.value,
        height: NumberConstant.onboardingIndicatorHeight,
        decoration: BoxDecoration(
          color: AppColors.primaryGreenColor,
          borderRadius: .circular(NumberConstant.onboardingIndicatorHeight),
        ),
      ),
    );
  }

  Widget _buildNextCta() {
    return ScaleTransition(
      scale: _ctaScale,
      child: AnimatedScale(
        scale: _ctaPressed ? NumberConstant.animPressScale : 1.0,
        duration: Duration(milliseconds: NumberConstant.animPressMs),
        curve: Curves.easeOut,
        child: GestureDetector(
          onTap: _onNextTap,
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
        ),
      ),
    );
  }
}
