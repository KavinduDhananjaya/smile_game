import 'package:shared_preferences/shared_preferences.dart';

class SharedMemory {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
  }

  setCurrentLevel(int level) async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
  }

  setQuestionCount(int count) async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
  }
}
