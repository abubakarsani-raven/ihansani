import 'package:go_router/go_router.dart';

class NavigationService {
  final GoRouter router;

  NavigationService(this.router); // Accept GoRouter in constructor

  void go(String route, {bool push = false}) {
    if (push) {
      router.push(route); // Navigate and push the route
    } else {
      router.replace(route); // Replace the current route
    }
  }

  void goBack() {
    if (router.canPop()) {
      router.pop(); // Perform the back navigation
    } else {
      // Perform any fallback behavior if required
      print("No route to pop!");
    }
  }

  // Method to check if we can go back
  bool canGoBack() {
    return router.canPop(); // Returns true if there's a route to pop
  }
}
