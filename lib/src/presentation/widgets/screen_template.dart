import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget body;

  const ScreenTemplate({required this.body, super.key});

  @override
  Widget build(BuildContext context) {
    const padding16 = 16;
    final mediaQueryData = MediaQuery.of(context);

    return MediaQuery(
      data: mediaQueryData.copyWith(textScaler: TextScaler.noScaling),
      child: Material(
        child: ColoredBox(
          color: const Color(0xFFEDEDED),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: padding16.h,
                left: padding16.w,
                right: padding16.w,
              ),
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
