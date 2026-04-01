import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherlite/storage/isar/services/isar_service.dart';

class DebugDestroyer {
  static const _launchMode = String.fromEnvironment('LAUNCH_MODE');

  static bool get isDebugReset => kDebugMode && _launchMode == 'debug';

  final IsarService _isarService;
  final SharedPreferences _prefs;

  DebugDestroyer({
    required IsarService isarService,
    required SharedPreferences prefs,
  }) : _isarService = isarService,
       _prefs = prefs;

  /// Wipes all data. Restart the app manually afterwards.
  Future<void> destroyAll() async {
    if (!kDebugMode) return;
    debugPrint('[DebugDestroyer] Wiping all data...');
    await Future.wait([clearIsar(), clearPreferences()]);
    debugPrint('[DebugDestroyer] Done. Restart the app to continue.');
  }

  Future<void> clearIsar() async {
    if (!kDebugMode) return;
    await _isarService.isar.writeTxn(() => _isarService.isar.clear());
  }

  Future<void> clearPreferences() async {
    if (!kDebugMode) return;
    await _prefs.clear();
  }
}
