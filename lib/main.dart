import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './src/app.dart';
import './src/config/config.dart';

void main() async {
  await initApplication();

  runApp(
    ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(375, 812),
      child: App(),
    ),
  );
}
