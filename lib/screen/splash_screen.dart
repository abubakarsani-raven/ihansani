
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/components/input_text_switcher.dart';
import 'package:project/components/login_app_bar.dart';
import 'package:project/components/radio_button.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/providers/go_router.dart';
import 'package:project/utils/screen_util.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ConsumerState<SplashScreen> {
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);
    final navigationService = ref.read(navigationProvider);
    final appSettings = ref.read(appSettingsProvider);

    return Scaffold(
      appBar: AppBarLoginPage(
        title: 'New Account',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenUtil.widthPercentage(90),
                child: Text(
                  'Choose a plan',
                  style: TextStyle(
                    fontSize: screenUtil.scaleFontSize(38),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                width: screenUtil.widthPercentage(60),
                child: Text(
                  'Unlock special features with premium plan',
                  style: TextStyle(
                    fontSize: screenUtil.scaleFontSize(15),
                    color: Colors.black87,
                  ),
                ),
              ),
              Row(
                spacing: 20,
                children: [
                  CustomRadioButton(
                    value: 1,
                    groupValue: _selectedValue,
                    onChanged: (value) =>
                        setState(() => _selectedValue = value),
                    label: "It's Free",
                    subtitle: 'Amazing core features',
                  ),
                  CustomRadioButton(
                    value: 2,
                    groupValue: _selectedValue,
                    onChanged: (value) =>
                        setState(() => _selectedValue = value),
                    label: "Premium",
                    subtitle: 'Coming Soon',
                  ),
                ],
              ),
              SizedBox(
                width: screenUtil.widthPercentage(90),
                child: Text(
                  'Enable Features',
                  style: TextStyle(
                    fontSize: screenUtil.scaleFontSize(38),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(
                width: screenUtil.widthPercentage(90),
                child: Text(
                  'You can customize these features for your account now. Or you can do it later in Settings ',
                  style: TextStyle(
                    fontSize: screenUtil.scaleFontSize(15),
                    color: Colors.black87,
                  ),
                ),
              ),
              IconTextSwitch(
                icon: Icons.calendar_today_rounded,
                text: 'Islamic Calendar',
                value: appSettings.isIslamicCalendarEnabled,
                onChanged: (value) {
                  ref.read(appSettingsProvider).toggleIslamicCalendar();
                },
              ),
              IconTextSwitch(
                icon: Icons.dark_mode_outlined,
                text: 'Dark Mode',
                value: appSettings.isDarkModeEnabled,
                onChanged: (value) {
                  ref.read(appSettingsProvider).toggleDarkMode();
                },
              ),
              SizedBox(
                height: screenUtil.heightPercentage(3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      appSettings.togglePreference();
                      navigationService.router.go('/home'); // Navigate to home
                    },
                    child: const Text('Skip'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      appSettings.togglePreference();
                      navigationService.router.go('/home'); // Navigate to home
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}