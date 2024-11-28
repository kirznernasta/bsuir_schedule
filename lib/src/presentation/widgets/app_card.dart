import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../presentation.dart';

class AppCard extends StatelessWidget {
  final String title;
  final bool hasTopRounded;
  final bool hasBottomRounded;
  final Widget? suffix;
  final String? subtitle;
  final VoidCallback? onTap;

  const AppCard({
    required this.title,
    required this.hasTopRounded,
    required this.hasBottomRounded,
    this.suffix,
    this.subtitle,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: 8.r.toBorderRadius(
                isTopRounded: hasTopRounded,
                isBottomRounded: hasBottomRounded,
              ),
        ),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        child: Row(
          children: [
            if (suffix != null) ...[
              suffix!,
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: textTheme.labelSmall?.copyWith(
                        color: Colors.black45,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.w,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
