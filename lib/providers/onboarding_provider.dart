import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingProvider = StateProvider<bool>((ref) => false);

final newUserPreferenceProvider = StateProvider<bool>((ref) => false);
