import 'package:shared_preferences/shared_preferences.dart';

class SnakeStore {
  late SharedPreferences _prefs;
  final String _kHighScore = 'HIGH_SCORE';
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void setHighScore(int highScore) {
    _prefs.setInt(_kHighScore, highScore);
  }

  int getHighScore() {
    return _prefs.containsKey(_kHighScore)
        ? _prefs.getInt(_kHighScore) ?? 0
        : 0;
  }
}
