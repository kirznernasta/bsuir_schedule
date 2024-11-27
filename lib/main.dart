import 'package:flutter/material.dart';

import './src/app.dart';
import './src/config/config.dart';

void main() async {
  await initApplication();

  runApp(const MyApp());
}
