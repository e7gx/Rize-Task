import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {

  static const _chatHistoryKey = 'chat_history';

  static Future<void> saveChatHistory(List<String> messages) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_chatHistoryKey, messages);
  }

  static Future<List<String>> getChatHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_chatHistoryKey) ?? [];
  }
}