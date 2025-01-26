import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'dart:async';

class AuthService extends AsyncNotifier<User?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<User?> build() async {
    // Monitor auth state changes and update Riverpod's state
    _auth.authStateChanges().listen((user) {
      state = AsyncData(user);
    });
    return _auth.currentUser;
  }

  // Email and Password Sign In
  Future<void> signInWithEmail(String email, String password) async {
    state = const AsyncLoading();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      state = AsyncData(_auth.currentUser);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    _setLoading();
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _setData(_auth.currentUser);
    } catch (e) {
      _setError(e);
    }
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    _setLoading();
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        _setData(_auth.currentUser);
      }
    } catch (e) {
      _setError(e);
    }
  }

  // Apple Sign-In
  Future<void> signInWithApple() async {
    _setLoading();
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oAuthProvider = OAuthProvider('apple.com');
      final credential = oAuthProvider.credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      // Optional: Update the user's display name
      if (appleCredential.givenName != null && appleCredential.familyName != null) {
        await userCredential.user?.updateDisplayName(
          '${appleCredential.givenName} ${appleCredential.familyName}',
        );
      }
      _setData(_auth.currentUser);
    } catch (e) {
      _setError(e);
    }
  }

  // Sign-Out
  Future<void> signOut() async {
    state = const AsyncLoading();
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  // Helper methods to manage state
  void _setLoading() {
    state = const AsyncLoading();
  }

  void _setData(User? user) {
    state = AsyncData(user);
  }

  void _setError(Object error) {
    state = AsyncError(error, StackTrace.current);
  }
}
