import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../gen/assets.gen.dart';
import '../../../router/router.dart';
import '../presentation.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const icons = Assets.icons;
    final iconSize = 40.w;
    final activeColorFilter = context.theme.primaryColor.colorFilter;
    final inactiveColorFilter = const Color(0xff646464).colorFilter;

    return AutoTabsScaffold(
      extendBody: true,
      animationDuration: Duration.zero,
      routes: const [
        GroupsRoute(),
        TeachersRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(height: 1.h, thickness: 1.h),
          SalomonBottomBar(
            selectedColorOpacity: 0,
            backgroundColor: const Color(0xFFEDEDED),
            onTap: tabsRouter.setActiveIndex,
            currentIndex: tabsRouter.activeIndex,
            margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 34.w),
            itemPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
            items: [
              SalomonBottomBarItem(
                icon: icons.group.svg(
                  width: iconSize,
                  colorFilter: inactiveColorFilter,
                ),
                activeIcon: icons.group.svg(
                  width: iconSize,
                  colorFilter: activeColorFilter,
                ),
                title: const Text('Groups'),
              ),
              SalomonBottomBarItem(
                icon: icons.idCard.svg(
                  width: iconSize,
                  colorFilter: inactiveColorFilter,
                ),
                activeIcon: icons.idCard.svg(
                  width: iconSize,
                  colorFilter: activeColorFilter,
                ),
                title: const Text('Teachers'),
              ),
              SalomonBottomBarItem(
                icon: icons.settings.svg(
                  width: iconSize,
                  colorFilter: inactiveColorFilter,
                ),
                activeIcon: icons.settings.svg(
                  width: iconSize,
                  colorFilter: activeColorFilter,
                ),
                title: const Text('Settings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
