import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

// AuthService provider
final authServiceProvider = AsyncNotifierProvider<AuthService, User?>(
      () => AuthService(),
);

// Firebase auth state changes provider (optional)
final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});
