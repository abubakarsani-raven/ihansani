import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/components/input_custom.dart';
import 'package:project/providers/auth_provider.dart';
import 'package:project/providers/go_router.dart';
import 'package:project/utils/screen_util.dart';

import '../components/login_app_bar.dart';

class RegisterPage extends ConsumerStatefulWidget {
  final bool isNewUser;
  final TextEditingController? emailController;

  const RegisterPage(
      {super.key, required this.isNewUser, this.emailController});

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);
    final navigationService = ref.read(navigationProvider);
    final authService = ref.read(authServiceProvider.notifier);
    return Scaffold(
      appBar: AppBarLoginPage(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenUtil.widthPercentage(100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isNewUser ? 'Sign Up' : "Login",
                        style: TextStyle(
                          fontSize: screenUtil.scaleFontSize(38),
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(
                        height: screenUtil.scaleHeight(10),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Using ',
                              style: TextStyle(
                                fontSize: screenUtil.scaleFontSize(14),
                                color: Colors.black87,
                              ),
                            ),
                            TextSpan(
                              text: widget.emailController?.text,
                              style: TextStyle(
                                  fontSize: screenUtil.scaleFontSize(14),
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                                  ' to sign ${widget.isNewUser ? 'up' : 'in'}',
                              style: TextStyle(
                                fontSize: screenUtil.scaleFontSize(14),
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (widget.isNewUser) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomTextField(
                    controller: _nameController,
                    label: 'Name',
                    trailingIcon: const Icon(Icons.cancel_outlined),
                    onTrailingIconPressed: () {
                      _nameController.clear();
                    },
                    keyboardType: TextInputType.text,
                    hintText: 'Enter your Name',
                  ),
                ),
                SizedBox(
                  height: screenUtil.scaleHeight(20),
                ),
              ],
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomTextField(
                  controller: _passwordController,
                  isPassword: true,
                  label: 'Password',
                  trailingIcon: const Icon(Icons.visibility),
                  onTrailingIconPressed: () {},
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Enter your Password',
                ),
              ),
              SizedBox(
                height: screenUtil.scaleHeight(20),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    widget.isNewUser
                        ? await authService.signUpWithEmail(
                            widget.emailController!.text,
                            _passwordController.text,
                          )
                        : await authService.signInWithEmail(
                            widget.emailController!.text,
                            _passwordController.text,
                          );
                    // TODO Change this check with some variable from firebase if he has not saved his preference but we can us a local storage like the onboarding provider
                    widget.isNewUser
                        ? navigationService.router.push('/newpreference')
                        : navigationService.router.push('/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    // Set button background color
                    foregroundColor: Colors.white,
                    // Set text/icon color
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ), // Adjust padding
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Sign ${widget.isNewUser ? 'up' : 'in'}'),
                      SizedBox(width: screenUtil.scaleWidth(10)),
                      // Spacing between text and icon
                      Icon(
                        Icons.email,
                        size: screenUtil.scaleFontSize(20),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
