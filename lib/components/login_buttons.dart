import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/providers/auth_provider.dart';
import 'package:project/providers/go_router.dart';
import 'package:project/utils/screen_util.dart';

class CustomButtons extends ConsumerWidget {
  const CustomButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.read(authServiceProvider.notifier);
    final navigationService = ref.read(navigationProvider);
    final screenUtil = ScreenUtil(context);

    return Column(
      spacing: screenUtil.heightPercentage(2.5),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                navigationService.go('/login', push: true); // Using go() to navigate
                print(navigationService.router.state?.error);
              },
              icon: Icon(
                Icons.email,
                size: 24,
                color: Colors.white,
              ),
              label: const Text('Continue with Email'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Set button background color
                foregroundColor: Colors.white, // Set text/icon color
                padding: const EdgeInsets.symmetric(
                    vertical: 12, horizontal: 16), // Adjust padding
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Google Button
            GestureDetector(
              onTap: () async {
                try {
                  await authService.signInWithGoogle();
                  navigationService.go('/home'); // Using go() after Google Sign-In
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Google Sign-In failed: $e")),
                    );
                  }
                }
              },
              child: Container(
                height: screenUtil.heightPercentage(6),
                width: screenUtil.widthPercentage(40),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                  borderRadius: BorderRadius.circular(screenUtil.widthPercentage(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      height: screenUtil.heightPercentage(3),
                      width: screenUtil.widthPercentage(6),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: screenUtil.widthPercentage(4)),
            // Apple Button
            GestureDetector(
              onTap: () async {
                try {
                  await authService.signInWithApple();
                  navigationService.go('/home'); // Using go() after Apple Sign-In
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Apple Sign-In failed: $e")),
                    );
                  }
                }
              },
              child: Container(
                height: screenUtil.heightPercentage(6),
                width: screenUtil.widthPercentage(40),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2),
                  borderRadius: BorderRadius.circular(screenUtil.widthPercentage(8)),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/apple.png',
                    height: screenUtil.heightPercentage(3),
                    width: screenUtil.widthPercentage(6),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              'By continuing you agree to our\nTerms of services and Privacy Policy',
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
