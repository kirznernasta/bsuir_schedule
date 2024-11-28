import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../presentation.dart';

class NoSearchResult extends StatelessWidget {
  final String searchInput;

  const NoSearchResult({required this.searchInput, super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.search.svg(
            width: 48.w,
            colorFilter: Colors.grey.colorFilter,
          ),
          Text(
            'No result for "$searchInput"',
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall,
          ),
          Text(
            'Check the spelling or try again',
            style: textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
