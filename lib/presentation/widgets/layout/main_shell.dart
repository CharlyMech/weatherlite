import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherlite/core/debug/debug_panel.dart';

import 'floating_bottom_navbar.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          navigationShell,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FloatingBottomNavbar(
              currentIndex: navigationShell.currentIndex,
              onTabSelected: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
            ),
          ),
          if (kDebugMode)
            Positioned(
              right: 16,
              top: 0,
              bottom: 0,
              child: Center(child: const DebugPanel()),
            ),
        ],
      ),
    );
  }
}
