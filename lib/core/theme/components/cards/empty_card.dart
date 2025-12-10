
import 'package:aorta/core/theme/components/button/aorta_filled_button.dart';
import 'package:aorta/core/theme/components/cards/gradient_card.dart';
import 'package:aorta/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyCard extends StatelessWidget {
  final String noun;
  final String? custom;
  final String icon;
  final Widget? slot;

  const EmptyCard({
    super.key,
    required this.noun,
    required this.icon,
    this.custom,
    this.slot,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          child: GradientCard(
            shape: BoxShape.circle,
            children: Padding(
              padding: EdgeInsets.all(4.w),
              child: SvgPicture.asset(
                icon,
                width: 25.w,
                height: 25.h,
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          custom ?? context.getLocalization()!.empty_template(noun),
          style: context.getTextTheme().bodySmall,
          textAlign: TextAlign.center,
        ),
        Container(child: slot),
      ],
    );
  }
}

class ErrorCard extends StatelessWidget {
  final String noun;
  final String? custom;
  final String icon;
  final VoidCallback action;
  final Widget? slot;

  const ErrorCard({
    super.key,
    required this.noun,
    required this.icon,
    required this.action,
    this.custom,
    this.slot,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(icon, width: 125.w, height: 125.h),
        SizedBox(height: 15.h),
        Text(
          custom ?? context.getLocalization()!.empty_template(noun),
          style: context.getTextTheme().labelLarge,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20.h),
        FittedBox(
          child: AortaFilledButton(
            text: context.getLocalization()!.retry,
            onPressed: action,
          ),
        ),
        Container(child: slot)
      ],
    );
  }
}

class HLoginCard extends StatelessWidget {
  final String noun;
  final String? custom;
  final String icon;

  const HLoginCard({
    super.key,
    required this.noun,
    required this.icon,
    this.custom,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        FittedBox(
          child: GradientCard(
            shape: BoxShape.circle,
            children: Padding(
              padding: EdgeInsets.all(4.w),
              child: SvgPicture.asset(icon, width: 25.w, height: 25.h),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          custom ?? "",
          style: context.getTextTheme().bodySmall,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        AortaFilledButton(
          text: "Login Now",
          visualDensity: const VisualDensity(
            horizontal: VisualDensity.minimumDensity,
            vertical: 0,
          ),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
        ),
      ],
    );
  }
}
