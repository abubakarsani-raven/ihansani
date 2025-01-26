import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/components/login_buttons.dart';
import 'package:project/providers/auth_provider.dart';
import 'package:project/providers/go_router.dart';
import 'package:project/providers/onboarding_provider.dart';
import 'package:project/utils/screen_util.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final navigationService = ref.read(navigationProvider);
    final authStateService = ref.read(authStateProvider);
    final authService = ref.read(authServiceProvider);

    void completeOnboarding() {
      ref.read(onboardingProvider.notifier).state = true;
      navigationService
          .go('/home'); // Navigate to home or root after onboarding
    }

    final screenUtil = ScreenUtil(context);

    final pages = [
      OnboardingPage(
        title: "Welcome!",
        description: "Discover how our app helps you stay productive.",
        imagePath: "assets/images/onboarding1.jpg",
        currentPage: _currentPage,
        totalPages: 3,
      ),
      OnboardingPage(
        title: "Organize",
        description: "Organize your tasks efficiently and effortlessly.",
        imagePath: "assets/images/onboarding2.jpg",
        currentPage: _currentPage,
        totalPages: 3,
      ),
      OnboardingPage(
        title: "Achieve",
        description: "Achieve your goals with our tools and insights.",
        imagePath: "assets/images/onboarding3.jpg",
        currentPage: _currentPage,
        totalPages: 3,
        isLastPage: true,
        onNext: completeOnboarding,
      ),
    ];

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              width: screenUtil.widthPercentage(100),
              height: screenUtil.heightPercentage(65),
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) => pages[index],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await ref.read(authServiceProvider.notifier).signOut();
              navigationService.router.go('/login');
            },
            child: Text('null ${authStateService.value == null}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomButtons(),
          )
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isLastPage;
  final VoidCallback? onNext;
  final int currentPage;
  final int totalPages;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.currentPage,
    required this.totalPages,
    this.isLastPage = false,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Container(
              height: screenUtil.heightPercentage(40),
              width: screenUtil.widthPercentage(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // Same border radius as the container
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover, // Ensures the image fills the space
                ),
              ),
            ),
            const SizedBox(height: 8), // Space between image and text
            // Title and Dots
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenUtil.scaleFontSize(24),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Description
                Text(
                  description,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: screenUtil.scaleFontSize(16),
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8),
                // Dot Indicators under the title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    totalPages,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      height: 8,
                      width: currentPage == index ? 16 : 8,
                      decoration: BoxDecoration(
                        color:
                            currentPage == index ? Colors.purple : Colors.grey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
