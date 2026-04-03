import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherlite/core/debug/debug_panel.dart';
import 'package:weatherlite/storage/preferences/app_preferences.dart';

import 'floating_bottom_navbar.dart';

class MainShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final _navbarKey = GlobalKey<FloatingBottomNavbarState>();

  @override
  Widget build(BuildContext context) {
    final prefs = context.read<AppPreferences>();
    final collapseBehavior = prefs.navbarCollapseBehavior;

    return Scaffold(
      extendBody: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Wrap the content in a listener that collapses the navbar
          // on external touch when using onExternalTouch behavior.
          Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (_) {
              _navbarKey.currentState?.collapseIfNeeded();
            },
            child: widget.navigationShell,
          ),
          Positioned(
            bottom: 32,
            left: 20,
            right: 20,
            child: Align(
              alignment: Alignment.centerRight,
              child: FloatingBottomNavbar(
                key: _navbarKey,
                currentIndex: widget.navigationShell.currentIndex,
                collapseBehavior: collapseBehavior,
                onTabSelected: (index) => widget.navigationShell.goBranch(
                  index,
                  initialLocation: index == widget.navigationShell.currentIndex,
                ),
              ),
            ),
          ),
          if (kDebugMode)
            Positioned(
              right: 16,
              top: 120,
              child: const DebugPanel(),
            ),
        ],
      ),
    );
  }
}
