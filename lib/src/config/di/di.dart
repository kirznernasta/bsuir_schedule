import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> initApplication() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set orientation to only portrait up.
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  GetItHelper(getIt);

  await $initGetIt(getIt);
}
