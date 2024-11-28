import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../src/presentation/presentation.dart';

part 'router.gr.dart';

@lazySingleton
@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends _$AppRouter {
  /// The default navigation animation.
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: HomeRoute.page,
      children: [
        AutoRoute(page: GroupsRoute.page),
        AutoRoute(page: TeachersRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}
