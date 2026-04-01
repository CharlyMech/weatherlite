import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Avatar placeholder
            CircleAvatar(
              radius: 48,
              backgroundColor: Theme.of(context)
                  .colorScheme
                  .surfaceContainerHighest,
              child: Icon(
                Icons.person,
                size: 48,
                color: Theme.of(context).colorScheme.onSurface.withValues(
                  alpha: 0.4,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Guest User',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to sync your data across devices',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Login/Register buttons (UI only)
            FilledButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.login),
              label: const Text('Sign in'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person_add),
              label: const Text('Create account'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const Spacer(),
            // App version
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                final version = snapshot.data?.version ?? '...';
                return Text(
                  'WeatherLite v$version',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withValues(alpha: 0.4),
                      ),
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
