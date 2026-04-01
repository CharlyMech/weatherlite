import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherlite/core/router/app_router.dart';
import 'package:weatherlite/core/theme/app_colors.dart';
import 'package:weatherlite/presentation/blocs/settings/settings_cubit.dart';
import 'package:weatherlite/presentation/blocs/theme/theme_cubit.dart';
import 'package:weatherlite/storage/preferences/app_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(
        appPrefs: context.read<AppPreferences>(),
      ),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatelessWidget {
  const _SettingsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Temperature unit
              _SectionHeader(title: 'Units'),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'C', label: Text('Celsius')),
                  ButtonSegment(value: 'F', label: Text('Fahrenheit')),
                ],
                selected: {state.temperatureUnit},
                onSelectionChanged: (value) {
                  context.read<SettingsCubit>().setTemperatureUnit(value.first);
                },
              ),

              const SizedBox(height: 32),

              // Theme
              _SectionHeader(title: 'Appearance'),
              const SizedBox(height: 8),
              SegmentedButton<ThemeType>(
                segments: const [
                  ButtonSegment(
                    value: ThemeType.light,
                    label: Text('Light'),
                    icon: Icon(Icons.light_mode, size: 18),
                  ),
                  ButtonSegment(
                    value: ThemeType.dark,
                    label: Text('Dark'),
                    icon: Icon(Icons.dark_mode, size: 18),
                  ),
                  ButtonSegment(
                    value: ThemeType.system,
                    label: Text('System'),
                    icon: Icon(Icons.settings_brightness, size: 18),
                  ),
                ],
                selected: {context.watch<ThemeCubit>().state},
                onSelectionChanged: (value) {
                  context.read<ThemeCubit>().setTheme(value.first);
                },
              ),

              const SizedBox(height: 32),

              // Location permission
              _SectionHeader(title: 'Privacy'),
              const SizedBox(height: 8),
              const _LocationPermissionTile(),

              const SizedBox(height: 48),

              // Logout
              OutlinedButton.icon(
                onPressed: () async {
                  final confirmed = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Log out?'),
                      content: const Text(
                        'This will reset the app and show the onboarding flow again.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx, false),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () => Navigator.pop(ctx, true),
                          child: const Text('Log out'),
                        ),
                      ],
                    ),
                  );

                  if (confirmed == true && context.mounted) {
                    await context.read<SettingsCubit>().logout();
                    if (context.mounted) {
                      context.go(AppRoutes.splash);
                    }
                  }
                },
                icon: const Icon(Icons.logout),
                label: const Text('Log out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LocationPermissionTile extends StatefulWidget {
  const _LocationPermissionTile();

  @override
  State<_LocationPermissionTile> createState() =>
      _LocationPermissionTileState();
}

class _LocationPermissionTileState extends State<_LocationPermissionTile> {
  LocationPermission _permission = LocationPermission.denied;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    final permission = await Geolocator.checkPermission();
    if (mounted) setState(() => _permission = permission);
  }

  bool get _isGranted =>
      _permission == LocationPermission.always ||
      _permission == LocationPermission.whileInUse;

  Future<void> _onToggle(bool enabled) async {
    if (!enabled) return; // can't revoke from app — user must go to OS settings

    if (_permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      await _checkPermission();
      return;
    }

    final result = await Geolocator.requestPermission();
    if (mounted) setState(() => _permission = result);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location Access',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (_permission == LocationPermission.deniedForever)
              Text(
                'Open Settings to enable',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
          ],
        ),
        CupertinoSwitch(
          value: _isGranted,
          onChanged: _onToggle,
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            letterSpacing: 0.5,
          ),
    );
  }
}
