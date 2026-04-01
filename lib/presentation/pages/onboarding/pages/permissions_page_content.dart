import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherlite/presentation/blocs/onboarding/onboarding_cubit.dart';
import 'package:weatherlite/presentation/blocs/onboarding/onboarding_state.dart';

class PermissionsPageContent extends StatefulWidget {
  const PermissionsPageContent({super.key});

  @override
  State<PermissionsPageContent> createState() => _PermissionsPageContentState();
}

class _PermissionsPageContentState extends State<PermissionsPageContent> {
  bool _pending = false;

  Future<void> _requestPermission() async {
    if (_pending) return;
    setState(() => _pending = true);
    await context.read<OnboardingCubit>().requestLocationPermission();
    if (mounted) setState(() => _pending = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ── Location permission ─────────────────────────────────────────
          Icon(
            Icons.location_on_outlined,
            size: 64,
            color: Colors.white.withValues(alpha: 0.9),
          ),
          const SizedBox(height: 24),
          Text(
            'Enable Location Services',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            'Allow WeatherLite to access your location\nso we can show your local weather.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  height: 1.5,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          BlocBuilder<OnboardingCubit, OnboardingState>(
            buildWhen: (prev, curr) =>
                prev.locationGranted != curr.locationGranted,
            builder: (context, state) {
              final granted = state.locationGranted;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Allow Location',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: granted ? Colors.greenAccent : Colors.white,
                        ),
                  ),
                  const SizedBox(width: 12),
                  if (_pending)
                    const SizedBox(
                      width: 51,
                      height: 31,
                      child: Center(
                        child: CupertinoActivityIndicator(color: Colors.white),
                      ),
                    )
                  else
                    CupertinoSwitch(
                      value: granted,
                      activeTrackColor: Colors.greenAccent,
                      onChanged: granted ? null : (_) => _requestPermission(),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 48),
          // ── Notifications (WIP) ─────────────────────────────────────────
          Divider(color: Colors.white.withValues(alpha: 0.15)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_outlined,
                size: 24,
                color: Colors.white.withValues(alpha: 0.3),
              ),
              const SizedBox(width: 8),
              Text(
                'Notifications — coming in v2',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
