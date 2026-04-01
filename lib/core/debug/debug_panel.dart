import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherlite/core/debug/debug_destroyer.dart';
import 'package:weatherlite/storage/isar/services/isar_service.dart';

/// A floating debug button + bottom sheet only visible in debug mode.
///
/// Drop anywhere in the widget tree as an overlay — it handles its own
/// visibility guard via [kDebugMode].
///
/// ```dart
/// Stack(
///   children: [
///     YourScreen(),
///     const DebugPanel(),
///   ],
/// )
/// ```
class DebugPanel extends StatelessWidget {
  const DebugPanel({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();
    return _DebugFab();
  }
}

class _DebugFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: 'debug_panel_fab',
      backgroundColor: Colors.red.shade700.withValues(alpha: 0.9),
      foregroundColor: Colors.white,
      tooltip: 'Debug Panel',
      onPressed: () => _showPanel(context),
      child: const Icon(Icons.bug_report, size: 20),
    );
  }

  void _showPanel(BuildContext context) {
    final isar = RepositoryProvider.of<IsarService>(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _DebugSheet(isarService: isar),
    );
  }
}

class _DebugSheet extends StatefulWidget {
  final IsarService isarService;
  const _DebugSheet({required this.isarService});

  @override
  State<_DebugSheet> createState() => _DebugSheetState();
}

class _DebugSheetState extends State<_DebugSheet> {
  bool _busy = false;
  String? _lastAction;

  Future<void> _run(String label, Future<void> Function() action) async {
    setState(() {
      _busy = true;
      _lastAction = null;
    });
    try {
      await action();
      if (mounted) setState(() => _lastAction = '✓ $label done');
    } catch (e) {
      if (mounted) setState(() => _lastAction = '✗ $label failed: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<DebugDestroyer> _destroyer() async {
    final prefs = await SharedPreferences.getInstance();
    return DebugDestroyer(isarService: widget.isarService, prefs: prefs);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.red.shade800, width: 1),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(Icons.bug_report, color: Colors.red.shade400, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Debug Destroyer',
                    style: TextStyle(
                      color: Colors.red.shade300,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  if (_busy)
                    const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Debug build only — all actions are irreversible.',
                style: TextStyle(color: Colors.white38, fontSize: 11),
              ),
              const SizedBox(height: 16),
              // Actions
              _ActionTile(
                icon: Icons.delete_sweep,
                label: 'Clear all data',
                subtitle: 'Isar + SharedPreferences',
                color: Colors.red.shade400,
                busy: _busy,
                onTap: () async {
                  final d = await _destroyer();
                  await _run('Clear all', d.destroyAll);
                },
              ),
              const SizedBox(height: 8),
              _ActionTile(
                icon: Icons.storage,
                label: 'Clear Isar only',
                subtitle: 'Locations, weather cache, layouts',
                color: Colors.orange.shade400,
                busy: _busy,
                onTap: () async {
                  final d = await _destroyer();
                  await _run('Clear Isar', d.clearIsar);
                },
              ),
              const SizedBox(height: 8),
              _ActionTile(
                icon: Icons.tune,
                label: 'Clear preferences only',
                subtitle: 'Theme, locale, hasLaunched, temp unit',
                color: Colors.orange.shade400,
                busy: _busy,
                onTap: () async {
                  final d = await _destroyer();
                  await _run('Clear prefs', d.clearPreferences);
                },
              ),
              // Result
              if (_lastAction != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _lastAction!,
                    style: TextStyle(
                      color: _lastAction!.startsWith('✓')
                          ? Colors.greenAccent
                          : Colors.redAccent,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final bool busy;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.busy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: busy ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: busy ? Colors.white24 : color, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        color: busy ? Colors.white38 : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white38,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: busy ? Colors.white12 : Colors.white24,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

