import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../router/router.dart';
import './config/config.dart';
import './presentation/presentation.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.hideKeyboard,
      child: MaterialApp.router(
        // TODO: add app theme
        //theme: AppTheme.theme,
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(
          deepLinkBuilder: (_) => const DeepLink([HomeRoute()]),
        ),
      ),
    );
  }
}
