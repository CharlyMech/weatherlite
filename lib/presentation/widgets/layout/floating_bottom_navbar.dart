import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iconoir_flutter/regular/home.dart' as iconoir_home;
import 'package:iconoir_flutter/regular/map.dart' as iconoir_map;
import 'package:iconoir_flutter/regular/nav_arrow_left.dart' as iconoir_expand;
import 'package:iconoir_flutter/regular/nav_arrow_right.dart' as iconoir_collapse;
import 'package:iconoir_flutter/regular/settings.dart' as iconoir_settings;
import 'package:iconoir_flutter/regular/user_circle.dart' as iconoir_user;

import '../../../core/theme/theme_extensions.dart';
import '../../../storage/preferences/app_preferences.dart';

class FloatingBottomNavbar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final NavbarCollapseBehavior collapseBehavior;

  const FloatingBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    this.collapseBehavior = NavbarCollapseBehavior.never,
  });

  @override
  State<FloatingBottomNavbar> createState() => FloatingBottomNavbarState();
}

class FloatingBottomNavbarState extends State<FloatingBottomNavbar>
    with TickerProviderStateMixin {
  int _activeIndex = 0;
  int _previousIndex = 0;
  bool _isExpanded = true;

  late final AnimationController _entranceController;
  late final Animation<double> _entranceAnimation;

  late final AnimationController _slideController;
  late Animation<double> _leftAnim;
  late Animation<double> _widthAnim;

  // Set by LayoutBuilder
  double _cellWidth = 0;
  double _pillBaseWidth = 0;
  double _navAreaFullWidth = 0;

  static const _barHeight = 60.0;
  static const _padding = 5.0;
  // The toggle slot is always a square on the right
  static const _toggleWidth = _barHeight;

  static const _items = [
    _NavItemData(label: 'Home', index: 0),
    _NavItemData(label: 'Map', index: 1),
    _NavItemData(label: 'Profile', index: 2),
    _NavItemData(label: 'Settings', index: 3),
  ];

  bool get isExpanded => _isExpanded;
  bool get _canCollapse =>
      widget.collapseBehavior != NavbarCollapseBehavior.never;

  void collapseIfNeeded() {
    if (widget.collapseBehavior == NavbarCollapseBehavior.onExternalTouch &&
        _isExpanded) {
      _setExpanded(false);
    }
  }

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.currentIndex;
    _previousIndex = widget.currentIndex;

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 380),
      vsync: this,
    );
    _leftAnim = ConstantTween<double>(0).animate(_slideController);
    _widthAnim = ConstantTween<double>(0).animate(_slideController);

    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _entranceAnimation = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutBack,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _entranceController.forward();
    });
  }

  @override
  void didUpdateWidget(FloatingBottomNavbar old) {
    super.didUpdateWidget(old);
    if (old.currentIndex != widget.currentIndex) {
      setState(() => _activeIndex = widget.currentIndex);
    }
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _setExpanded(bool expanded) {
    setState(() => _isExpanded = expanded);
    if (!expanded) _slideController.stop();
  }

  void _selectTab(int index) {
    if (index == _activeIndex) return;
    _previousIndex = _activeIndex;
    setState(() => _activeIndex = index);
    widget.onTabSelected(index);
    _animatePill(from: _previousIndex, to: index);
  }

  void _animatePill({required int from, required int to}) {
    if (_cellWidth == 0) return;

    final fromLeft =
        _cellWidth * from + (_cellWidth - _pillBaseWidth) / 2;
    final toLeft =
        _padding + _cellWidth * to + (_cellWidth - _pillBaseWidth) / 2;

    _widthAnim = ConstantTween<double>(_pillBaseWidth).animate(_slideController);
    _leftAnim = Tween<double>(begin: fromLeft, end: toLeft).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOutCubic),
    );

    _slideController
      ..reset()
      ..forward();
  }

  Widget _iconFor(int index, Color color) => switch (index) {
        0 => iconoir_home.Home(color: color, width: 22, height: 22),
        1 => iconoir_map.Map(color: color, width: 22, height: 22),
        2 => iconoir_user.UserCircle(color: color, width: 22, height: 22),
        3 => iconoir_settings.Settings(color: color, width: 22, height: 22),
        _ => iconoir_home.Home(color: color, width: 22, height: 22),
      };

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) => IgnorePointer(
        ignoring: _entranceController.value == 0,
        child: ScaleTransition(
          scale: _entranceAnimation,
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      ),
      child: _buildBar(context),
    );
  }

  Widget _buildBar(BuildContext context) {
    final borderColor = context.appColors.outline.withValues(alpha: 0.15);
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Nav area = full width minus toggle slot (when collapsible).
        // Subtract 2px for the 1px border on each side.
        const borderWidth = 2.0;
        _navAreaFullWidth = _canCollapse
            ? constraints.maxWidth - _toggleWidth - borderWidth
            : constraints.maxWidth - borderWidth;

        _pillBaseWidth = _barHeight - _padding * 2;

        return ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: _barHeight,
              decoration: BoxDecoration(
                color: context.glassColor,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // ── Nav area: animates width 0 ↔ full ──────────────────
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeInOutCubic,
                    width: _isExpanded ? _navAreaFullWidth : 0,
                    height: _barHeight,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: _buildNavArea(context, borderColor, onSurface),
                  ),

                  // ── Toggle button: always visible on the right ──────────
                  if (_canCollapse)
                    SizedBox(
                      width: _toggleWidth,
                      height: _barHeight,
                      child: GestureDetector(
                        onTap: () => _setExpanded(!_isExpanded),
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 220),
                            transitionBuilder: (child, anim) => FadeTransition(
                              opacity: anim,
                              child: ScaleTransition(scale: anim, child: child),
                            ),
                            child: _isExpanded
                                ? iconoir_collapse.NavArrowRight(
                                    key: const ValueKey('collapse'),
                                    color: onSurface.withValues(alpha: 0.4),
                                    width: 20,
                                    height: 20,
                                  )
                                : iconoir_expand.NavArrowLeft(
                                    key: const ValueKey('expand'),
                                    color: onSurface.withValues(alpha: 0.8),
                                    width: 20,
                                    height: 20,
                                  ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavArea(
      BuildContext context, Color borderColor, Color onSurface) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1) return const SizedBox.shrink();

        _cellWidth = constraints.maxWidth / _items.length;

        final pillLeft =
            _cellWidth * _activeIndex + (_cellWidth - _pillBaseWidth) / 2;

        return AnimatedBuilder(
          animation: _slideController,
          builder: (context, _) {
            final isSliding = _slideController.isAnimating;
            final left = isSliding ? _leftAnim.value : pillLeft;
            final width = isSliding ? _widthAnim.value : _pillBaseWidth;

            return Stack(
              children: [
                // Pill background
                Positioned(
                  left: left,
                  top: (_barHeight - _pillBaseWidth) / 2,
                  bottom: (_barHeight - _pillBaseWidth) / 2,
                  width: width,
                  child: _PillBackground(
                    borderColor: borderColor,
                    glassColor: context.glassColor,
                  ),
                ),
                // Icons row — always above pill
                Row(
                  children: List.generate(_items.length, (i) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => _selectTab(i),
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: _iconFor(
                            i,
                            onSurface.withValues(
                              alpha: i == _activeIndex ? 1.0 : 0.45,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _PillBackground extends StatelessWidget {
  final Color borderColor;
  final Color glassColor;

  const _PillBackground({required this.borderColor, required this.glassColor});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: glassColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.10),
                Colors.white.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _NavItemData {
  final String label;
  final int index;
  const _NavItemData({required this.label, required this.index});
}
