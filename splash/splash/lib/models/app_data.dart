import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static const String _welcomeMessageKey = 'welcome_message';
  static const String _launchCountKey = 'launch_count';
  static const String _firstLaunchDateKey = 'first_launch_date';

  // Get welcome message (in Arabic)
  static String get welcomeMessage => 'مرحباً بكم في تطبيق كلية الهندسة';

  // Save first launch data
  static Future<void> saveFirstLaunchData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstLaunch', false);
    await prefs.setString(_welcomeMessageKey, welcomeMessage);
    await prefs.setString(_firstLaunchDateKey, DateTime.now().toIso8601String());
    await prefs.setInt(_launchCountKey, 1);
  }

  // Get app statistics
  static Future<Map<String, dynamic>> getAppStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Get or initialize launch count
      final launchCount = (prefs.getInt(_launchCountKey) ?? 0) + 1;
      await prefs.setInt(_launchCountKey, launchCount);
      
      // Get first launch date or use current date if not set
      String? firstLaunchDateStr = prefs.getString(_firstLaunchDateKey);
      DateTime firstLaunchDate;
      
      if (firstLaunchDateStr == null) {
        firstLaunchDate = DateTime.now();
        await prefs.setString(_firstLaunchDateKey, firstLaunchDate.toIso8601String());
      } else {
        firstLaunchDate = DateTime.parse(firstLaunchDateStr);
      }
      
      // Calculate days since first launch
      final daysSinceFirstLaunch = DateTime.now().difference(firstLaunchDate).inDays;
      
      return {
        'welcomeMessage': prefs.getString(_welcomeMessageKey) ?? welcomeMessage,
        'launchCount': launchCount,
        'firstLaunchDate': firstLaunchDate.toIso8601String(),
        'daysSinceFirstLaunch': daysSinceFirstLaunch,
      };
    } catch (e) {
      // Return default values in case of error
      final now = DateTime.now();
      return {
        'welcomeMessage': welcomeMessage,
        'launchCount': 1,
        'firstLaunchDate': now.toIso8601String(),
        'daysSinceFirstLaunch': 0,
      };
    }
  }
}
