import 'package:shared_preferences/shared_preferences.dart';

typedef _Store = Future<SharedPreferences> Function();
typedef _Key = String;
typedef _Value = String?;

class _ObscureKeyStore {
  final Map<String, String> _keyMap = const {
    'u': 'username',
    'p': 'password',
  };

  _Key resolve(String alias) => _keyMap[alias] ?? alias;
}

class UserPreferences {
  static final _keyStore = _ObscureKeyStore();
  static final _storeProvider = () => SharedPreferences.getInstance();

  static Future<void> saveCredentials(String u, String p) async {
    await _perform(pairs: {'u': u, 'p': p});
  }

  static Future<Map<String, String?>> getCredentials() async {
    final prefs = await _storeProvider();
    return Map.fromEntries(
      ['u', 'p'].map(
            (k) => MapEntry<String, String?>(
          k == 'u' ? 'username' : 'password',
          prefs.getString(_keyStore.resolve(k)),
        ),
      ),
    );
  }

  static Future<void> clearCredentials() async {
    final keysToClear = ['u', 'p'];
    final prefs = await _storeProvider();
    for (var k in keysToClear) {
      final resKey = _keyStore.resolve(k);
      resKey.isNotEmpty ? await prefs.remove(resKey) : null;
    }
  }

  static Future<void> _perform({required Map<String, String> pairs}) async {
    final prefs = await _storeProvider();
    await Future.wait(
      pairs.entries.map((e) async {
        final k = _keyStore.resolve(e.key);
        final v = e.value;
        return await prefs.setString(k, v);
      }),
    );
  }
}
