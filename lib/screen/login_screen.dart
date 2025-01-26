import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/components/input_custom.dart';
import 'package:project/providers/go_router.dart';
import 'package:project/utils/screen_util.dart';
import '../components/login_app_bar.dart';

class Login extends ConsumerStatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);
    final navigationService = ref.read(navigationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarLoginPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenUtil.widthPercentage(60),
                child: Text(
                  'What is your email address?',
                  style: TextStyle(
                    fontSize: screenUtil.scaleFontSize(38),
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: CustomTextField(
                  controller: _emailController,
                  label: 'Your Email',
                  trailingIcon: const Icon(Icons.cancel_outlined),
                  onTrailingIconPressed: () {
                    _emailController.clear();
                  },
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter your email address',
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      navigationService.router.push(
                        '/register',
                        extra: {
                          'emailController': _emailController,
                          'isNewUser': true
                        },
                      );
                    },
                    icon: Icon(
                      Icons.email,
                      size: 24,
                      color: Colors.white,
                    ),
                    label: const Text('Continue with Email'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      // Set button background color
                      foregroundColor: Colors.white,
                      // Set text/icon color
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16), // Adjust padding
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('Already have an account '),
                    GestureDetector(
                      onTap: () {
                        navigationService.router.push(
                          '/register',
                          extra: {
                            'emailController': _emailController,
                            'isNewUser': false
                          },
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.purpleAccent,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
