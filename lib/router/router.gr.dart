// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ExitConfirmationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ExitConfirmationScreen(),
      );
    },
    GroupsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const GroupsScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    ScheduleRoute.name: (routeData) {
      final args = routeData.argsAs<ScheduleRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ScheduleScreen(
          id: args.id,
          isFavourite: args.isFavourite,
          isGroupSchedule: args.isGroupSchedule,
          searchingInput: args.searchingInput,
          title: args.title,
          key: args.key,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    SignInRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignInScreen(),
      );
    },
    SignUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignUpScreen(),
      );
    },
    TeachersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TeachersScreen(),
      );
    },
  };
}

/// generated route for
/// [ExitConfirmationScreen]
class ExitConfirmationRoute extends PageRouteInfo<void> {
  const ExitConfirmationRoute({List<PageRouteInfo>? children})
      : super(
          ExitConfirmationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExitConfirmationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [GroupsScreen]
class GroupsRoute extends PageRouteInfo<void> {
  const GroupsRoute({List<PageRouteInfo>? children})
      : super(
          GroupsRoute.name,
          initialChildren: children,
        );

  static const String name = 'GroupsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ScheduleScreen]
class ScheduleRoute extends PageRouteInfo<ScheduleRouteArgs> {
  ScheduleRoute({
    required int id,
    required bool isFavourite,
    required bool isGroupSchedule,
    required String searchingInput,
    String? title,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ScheduleRoute.name,
          args: ScheduleRouteArgs(
            id: id,
            isFavourite: isFavourite,
            isGroupSchedule: isGroupSchedule,
            searchingInput: searchingInput,
            title: title,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ScheduleRoute';

  static const PageInfo<ScheduleRouteArgs> page =
      PageInfo<ScheduleRouteArgs>(name);
}

class ScheduleRouteArgs {
  const ScheduleRouteArgs({
    required this.id,
    required this.isFavourite,
    required this.isGroupSchedule,
    required this.searchingInput,
    this.title,
    this.key,
  });

  final int id;

  final bool isFavourite;

  final bool isGroupSchedule;

  final String searchingInput;

  final String? title;

  final Key? key;

  @override
  String toString() {
    return 'ScheduleRouteArgs{id: $id, isFavourite: $isFavourite, isGroupSchedule: $isGroupSchedule, searchingInput: $searchingInput, title: $title, key: $key}';
  }
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignInScreen]
class SignInRoute extends PageRouteInfo<void> {
  const SignInRoute({List<PageRouteInfo>? children})
      : super(
          SignInRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignUpScreen]
class SignUpRoute extends PageRouteInfo<void> {
  const SignUpRoute({List<PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TeachersScreen]
class TeachersRoute extends PageRouteInfo<void> {
  const TeachersRoute({List<PageRouteInfo>? children})
      : super(
          TeachersRoute.name,
          initialChildren: children,
        );

  static const String name = 'TeachersRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
