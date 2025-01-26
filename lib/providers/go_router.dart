import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project/components/on_boarding.dart';
import 'package:project/providers/app_provider.dart';
import 'package:project/providers/auth_provider.dart';
import 'package:project/screen/home_screen.dart';
import 'package:project/screen/login_screen.dart';
import 'package:project/screen/register_page.dart';
import 'package:project/screen/splash_screen.dart';
import 'package:project/service/navigation_service.dart';

// Provide the GoRouter instance to NavigationService
final goRouterProvider = Provider<GoRouter>((ref) {
  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,

    onException: (context, state, router) {
      print('Context $context');
      print('State $state');
      print('Router $router');
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final emailController = extra?['emailController'] as TextEditingController?;
          final isNewUser = extra?['isNewUser'] as bool? ?? false;

          return RegisterPage(
            emailController: emailController ?? TextEditingController(),
            isNewUser: isNewUser,
          );
        },
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/newpreference',
        builder: (context, state) => const SplashScreen(),
      ),
    ],
    // redirect: (context, state) {
    //   final authState = ref.watch(authStateProvider);
    //   final appSetting = ref.watch(appSettingsProvider);
    //
    //   if (authState.isLoading) {
    //     return '/loading';
    //   }
    //
    //   final isAuthenticated = authState.value != null;
    //   final isPreferenceComplete = appSetting.isPreferenceComplete;
    //   final currentPath = state.uri.toString();
    //
    //   if (!isAuthenticated && currentPath != '/') {
    //     return '/';
    //   }
    //
    //   if (isAuthenticated && !isPreferenceComplete && currentPath != '/newpreference') {
    //     return '/newpreference';
    //   }
    //
    //   if (isAuthenticated && isPreferenceComplete && currentPath == '/newpreference') {
    //     return '/home';
    //   }
    //
    //   return null;
    // },
    debugLogDiagnostics: true,
  );
});

// Provide NavigationService to access navigation functionality
final navigationProvider = Provider<NavigationService>((ref) {
  final goRouter = ref.read(goRouterProvider); // Read the GoRouter instance
  return NavigationService(goRouter); // Pass the GoRouter to NavigationService
});

