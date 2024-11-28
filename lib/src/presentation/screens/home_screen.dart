import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final iconSize = 40.w;

    return AutoTabsScaffold(
      extendBody: true,
      animationDuration: Duration.zero,
      routes: const [
        GroupsRoute(),
        TeachersRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) => SalomonBottomBar(
        selectedColorOpacity: 0,
        backgroundColor: Colors.grey,
        onTap: tabsRouter.setActiveIndex,
        currentIndex: tabsRouter.activeIndex,
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 34.w),
        itemPadding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.group, size: iconSize),
            title: const Text('Groups'),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.switch_account, size: iconSize),
            // activeIcon: Icon(Icons.add),
            title: const Text('Teachers'),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.settings, size: iconSize),
            title: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
