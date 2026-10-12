import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProgressSnapshot {
  ProgressSnapshot({
    Map<String, int>? answers,
    Map<String, List<int>>? practices,
  }) : answers = Map.unmodifiable(answers ?? {}),
       practices = Map.unmodifiable(
         (practices ?? {}).map(
           (key, value) => MapEntry(key, List<int>.unmodifiable(value)),
         ),
       );
  final Map<String, int> answers;
  final Map<String, List<int>> practices;

  String encode() =>
      jsonEncode({'version': 1, 'answers': answers, 'practices': practices});

  factory ProgressSnapshot.decode(String raw) {
    final json = jsonDecode(raw);
    if (json is! Map ||
        json['version'] != 1 ||
        json['answers'] is! Map ||
        json['practices'] is! Map) {
      throw const FormatException('Estado local incompatible');
    }
    return ProgressSnapshot(
      answers: Map<String, int>.from(json['answers'] as Map),
      practices: (json['practices'] as Map).map(
        (key, value) => MapEntry(key as String, List<int>.from(value as List)),
      ),
    );
  }
}

abstract interface class ProgressStore {
  Future<ProgressSnapshot> load();
  Future<void> save(ProgressSnapshot state);
}

class LocalProgressStore implements ProgressStore {
  LocalProgressStore({
    SharedPreferencesAsync? preferences,
    this.key = storageKey,
  }) : _preferences = preferences ?? SharedPreferencesAsync();
  final SharedPreferencesAsync _preferences;
  static const storageKey = 'psps.progress.v1';
  final String key;

  @override
  Future<ProgressSnapshot> load() async {
    final raw = await _preferences.getString(key);
    return raw == null ? ProgressSnapshot() : ProgressSnapshot.decode(raw);
  }

  @override
  Future<void> save(ProgressSnapshot state) =>
      _preferences.setString(key, state.encode());
}
