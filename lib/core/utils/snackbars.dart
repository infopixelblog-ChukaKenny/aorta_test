import 'package:aorta/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AortaErrorSnackBar(String message, BuildContext context) => SnackBar(
  backgroundColor: context.getColorScheme().error,
  content: Builder(
    builder: (context) {
      return Container(
        decoration: BoxDecoration(color: context.getColorScheme().error),
        child: Row(
          children: [
            FaIcon(
              Icons.cancel,
              size: 25.w,
              color: context.getColorScheme().onPrimary,
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                message == UNKNOWN_ERROR_STRING
                    ? context.getLocalization()!.something_went_wrong
                    : message,
                style: context.getTextTheme().titleSmall?.copyWith(
                  color: context.getColorScheme().onPrimary,
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
);

AortaSuccessSnackbar(String message, BuildContext context) => SnackBar(
  backgroundColor: Colors.green,
  content: Container(
    decoration: const BoxDecoration(color: Colors.green),
    child: Row(
      children: [
        FaIcon(
          Icons.check_circle,
          size: 25.w,
          color: context.getColorScheme().onPrimary,
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Text(
            message,
            style: context.getTextTheme().titleSmall?.copyWith(
              color: context.getColorScheme().onPrimary,
            ),
          ),
        ),
      ],
    ),
  ),
);
