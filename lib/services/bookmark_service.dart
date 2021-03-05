import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences _preferences;

  static const _keyUserID = 'userid';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserIDs(List<String> ids) async =>
      await _preferences.setStringList(_keyUserID, ids);

  static List<String> getUserIDs() => _preferences.getStringList(_keyUserID);

  static Future removeUserID(String id) async =>
      await _preferences.remove(_keyUserID);
}
