import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../domain/domain.dart';

extension BuildContextExt on BuildContext {
  /// Application theme.
  ThemeData get theme => Theme.of(this);

  void hideKeyboard() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}

extension ColorExt on Color? {
  ColorFilter? get colorFilter {
    final color = this;

    return color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null;
  }
}

extension RadiusExt on double {
  BorderRadius toBorderRadius({
    bool isTopRounded = false,
    bool isBottomRounded = false,
  }) {
    if (isTopRounded && isBottomRounded) {
      return BorderRadius.circular(this);
    }

    final radius = Radius.circular(this);

    if (isTopRounded) {
      return BorderRadius.only(topLeft: radius, topRight: radius);
    }
    if (isBottomRounded) {
      return BorderRadius.only(bottomLeft: radius, bottomRight: radius);
    }

    return BorderRadius.zero;
  }
}

extension SubgroupTypeExt on SubgroupType {
  Widget get icon {
    return switch (this) {
      SubgroupType.subgroup1 => Row(
          children: [
            Assets.icons.person.svg(
              width: 24.w,
              colorFilter: Colors.grey.colorFilter,
            ),
            Text('1'),
          ],
        ),
      SubgroupType.subgroup2 => Row(
          children: [
            Assets.icons.person.svg(
              width: 24.w,
              colorFilter: Colors.grey.colorFilter,
            ),
            Text('2'),
          ],
        ),
      SubgroupType.all => Assets.icons.groups.svg(
          width: 24.w,
          colorFilter: Colors.grey.colorFilter,
        ),
    };
  }
}

extension LessonTypeExt on LessonType {
  Color get color {
    return switch (this) {
      LessonType.lecture => Colors.green,
      LessonType.lab => Colors.yellow,
      LessonType.practical => Colors.red,
      LessonType.exam => Colors.purple,
      LessonType.consultation => Colors.brown,
      LessonType.unknown => Colors.grey,
    };
  }
}
