import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviewave/core/res/style/app_colors.dart';
import 'package:moviewave/core/services/routes.dart';
import 'package:moviewave/src/navigation/presentation/utils/navigation_utils.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key, required this.state, required this.child});

  final GoRouterState state;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final activeIndex = NavigationUtils.activeIndex(state);
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppColors.mainColor,
        items: NavigationUtils.icons.mapIndexed((index, item) {
          return BottomNavigationBarItem(
            icon: Icon(activeIndex == index ? item.$2 : item.$1),
            label: item.$3,
          );
        }).toList(),
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(Routes.home);
            case 1:
              context.go(Routes.nowPlaying);
            case 2:
              context.go(Routes.tvShow);
            case 3:
              context.go(Routes.search);
          }
        },
      ),
    );
  }
}
