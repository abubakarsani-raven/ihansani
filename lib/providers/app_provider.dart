import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// State class to manage Islamic calendar and dark mode
class AppSettings extends ChangeNotifier {
  bool isIslamicCalendarEnabled = false;
  bool isDarkModeEnabled = false;
  bool isPreferenceComplete = false;

  // Toggle Islamic calendar state
  void toggleIslamicCalendar() {
    isIslamicCalendarEnabled = !isIslamicCalendarEnabled;
    notifyListeners();
  }

  // Toggle dark mode state
  void toggleDarkMode() {
    isDarkModeEnabled = !isDarkModeEnabled;
    notifyListeners();
  }
  // Toggle show Preference state
  void togglePreference() {
    isPreferenceComplete = true;
    print('In provider $isPreferenceComplete' );
    notifyListeners();
  }
}

// Riverpod provider for AppSettings
final appSettingsProvider = ChangeNotifierProvider((ref) => AppSettings());
