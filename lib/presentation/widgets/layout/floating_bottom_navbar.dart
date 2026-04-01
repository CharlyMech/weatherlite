import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconoir_flutter/regular/home.dart' as iconoir_home;
import 'package:iconoir_flutter/regular/map.dart' as iconoir_map;
import 'package:iconoir_flutter/regular/menu.dart' as iconoir_menu;
import 'package:iconoir_flutter/regular/settings.dart' as iconoir_settings;
import 'package:iconoir_flutter/regular/user_circle.dart' as iconoir_user;
import 'package:iconoir_flutter/regular/xmark.dart' as iconoir_xmark;

import '../../../core/animations/app_animations.dart';
import '../../../core/theme/theme_extensions.dart';

class FloatingBottomNavbar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const FloatingBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  State<FloatingBottomNavbar> createState() => _FloatingBottomNavbarState();
}

class _FloatingBottomNavbarState extends State<FloatingBottomNavbar>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;

  late int _activeIndex;

  static const _items = [
    _NavItemData(label: 'Home', index: 0),
    _NavItemData(label: 'Map', index: 1),
    _NavItemData(label: 'Profile', index: 2),
    _NavItemData(label: 'Settings', index: 3),
  ];

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.currentIndex;
    _controller = AnimationController(
      duration: AppAnimations.medium,
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: AppAnimations.curve,
    );
  }

  @override
  void didUpdateWidget(FloatingBottomNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() => _activeIndex = widget.currentIndex);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _isExpanded = !_isExpanded);
    if (_isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _collapse() {
    if (_isExpanded) _toggle();
  }

  void _selectTab(int index) {
    setState(() => _activeIndex = index);
    widget.onTabSelected(index);
    // Do NOT collapse — navbar stays open after tab selection
  }

  Widget _iconFor(int index, Color color) {
    switch (index) {
      case 0:
        return iconoir_home.Home(color: color, width: 22, height: 22);
      case 1:
        return iconoir_map.Map(color: color, width: 22, height: 22);
      case 2:
        return iconoir_user.UserCircle(color: color, width: 22, height: 22);
      case 3:
        return iconoir_settings.Settings(color: color, width: 22, height: 22);
      default:
        return iconoir_home.Home(color: color, width: 22, height: 22);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight,
      child: Stack(
        children: [
          // Dismiss overlay (tap outside to collapse)
          if (_isExpanded)
            Positioned.fill(
              child: GestureDetector(
                onTap: _collapse,
                behavior: HitTestBehavior.opaque,
                child: const SizedBox.expand(),
              ),
            ),
          // Navbar — anchored to bottom-right
          Positioned(
            bottom: 32,
            right: 20,
            child: AnimatedBuilder(
              animation: _expandAnimation,
              builder: (context, _) => _buildBar(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    final fillColor = context.glassColor;
    final borderColor = context.appColors.outline.withValues(alpha: 0.15);

    // Expand from right: collapsed pill is 56 wide, expands leftward to fill
    final maxWidth = MediaQuery.of(context).size.width - 40;
    final width = lerpDouble(56, maxWidth, _expandAnimation.value)!;
    final radius = lerpDouble(28, 20, _expandAnimation.value)!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: width,
          height: 60,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: borderColor),
          ),
          child: _isExpanded || _expandAnimation.value > 0
              ? _buildExpandedContent(context)
              : _buildCollapsedContent(context),
        ),
      ),
    );
  }

  Widget _buildCollapsedContent(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSurface;
    return GestureDetector(
      onTap: _toggle,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: iconoir_menu.Menu(color: iconColor, width: 22, height: 22),
      ),
    );
  }

  Widget _buildExpandedContent(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSurface;
    final pillColor = context.glassColor;
    final pillBorder = context.appColors.outline.withValues(alpha: 0.15);

    final opacity = (_expandAnimation.value * 2 - 1).clamp(0.0, 1.0);

    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Nav items — each constrained so the active pill label doesn't overflow
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _items.map((item) {
                  final isActive = _activeIndex == item.index;
                  final itemIcon = _iconFor(item.index, iconColor);

                  return Flexible(
                    child: _AnimatedNavItem(
                      icon: itemIcon,
                      isActive: isActive,
                      pillColor: pillColor,
                      pillBorder: pillBorder,
                      delay: item.index,
                      animation: _expandAnimation,
                      onTap: () => _selectTab(item.index),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Divider
            Container(
              width: 1,
              height: 28,
              color: context.appColors.outline.withValues(alpha: 0.15),
              margin: const EdgeInsets.symmetric(horizontal: 4),
            ),

            // Close button
            GestureDetector(
              onTap: _collapse,
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 40,
                height: 60,
                child: Center(
                  child: iconoir_xmark.Xmark(
                    color: iconColor.withValues(alpha: 0.6),
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItemData {
  final String label;
  final int index;
  const _NavItemData({required this.label, required this.index});
}

class _AnimatedNavItem extends StatelessWidget {
  final Widget icon;
  final bool isActive;
  final Color pillColor;
  final Color pillBorder;
  final int delay;
  final Animation<double> animation;
  final VoidCallback onTap;

  const _AnimatedNavItem({
    required this.icon,
    required this.isActive,
    required this.pillColor,
    required this.pillBorder,
    required this.delay,
    required this.animation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final staggerStart = delay * 0.1;
        final progress =
            ((animation.value - staggerStart) / (1 - staggerStart))
                .clamp(0.0, 1.0);

        return Opacity(
          opacity: progress,
          child: Transform.scale(
            scale: 0.6 + progress * 0.4,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: AppAnimations.medium,
          curve: AppAnimations.curve,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: isActive
              ? BoxDecoration(
                  color: pillColor,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: pillBorder),
                )
              : null,
          child: Center(child: icon),
        ),
      ),
    );
  }
}
