

import 'package:shared_preferences/shared_preferences.dart';

class _StringSharedPreferencesProvider {
  const _StringSharedPreferencesProvider(this.key);
  final String key;

  Future<String> getPref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> setPref(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> removePref() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}

class _BoolSharedPreferencesProvider {
  const _BoolSharedPreferencesProvider(this.key);
  final String key;

  Future<bool> getPref() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> setPref({bool value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}

const checkoutIdPref = _StringSharedPreferencesProvider('CheckoutId');
const customerAccessTokenPref = _StringSharedPreferencesProvider('AccessToken');
const firstTimeOpenPref = _BoolSharedPreferencesProvider('FirstTimeOpen');
