import 'package:shared_preferences/shared_preferences.dart';

class SharedFunctions {
  static String sharedPreferencesWatchList = "WatchList";

  static Future<bool> saveUserWatchList(List<String>WatchList) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(sharedPreferencesWatchList, WatchList);
      return true;
    } catch (e) {
      print("error saving Watchlist to shared preferences");
      return false;
    }
  }

  static Future<List<String>> getUserWatchList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(sharedPreferencesWatchList)?? <String>[]);
  }

}