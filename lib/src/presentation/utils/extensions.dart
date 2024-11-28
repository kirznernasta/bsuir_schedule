import 'package:flutter/material.dart';

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
