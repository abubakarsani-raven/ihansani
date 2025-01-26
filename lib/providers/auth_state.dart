import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthState with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

  bool _isSignIn = true;

  bool get isSignIn => _isSignIn;
  User? get user => _user;

  // Initialize the state with authStateChanges
  AuthState() {
    _auth.authStateChanges().listen((user) {
      _user = user;
      _isSignIn = user != null; // If user is not null, they are signed in
      notifyListeners();
    });
  }

  // Toggle between sign-in and sign-up mode
  void toggleAuthMode() {
    _isSignIn = !_isSignIn;
    notifyListeners();
  }

  // Sign in with Google
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
      }
    } catch (e) {
      throw Exception('Google Sign-In failed: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Sign-Out failed: $e');
    }
  }
}
