import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/providers/go_router.dart';

class AppBarLoginPage extends ConsumerWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBackPressed;
  final String? avatarUrl;

  const AppBarLoginPage({
    super.key,
    this.title,
    this.avatarUrl,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = ref.read(navigationProvider);  // Read navigationService from provider
    return PreferredSize(
      preferredSize: const Size.fromHeight(100), // Adjust height of AppBar
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            decoration: const BoxDecoration(
              color: Colors.transparent, // Transparent background
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back Arrow with Border
                    GestureDetector(
                      onTap: () {
                        if (navigationService.canGoBack()) {
                          navigationService.goBack(); // Go back using navigation service
                        } else {
                          // You could exit the app or perform other actions if needed
                          // exit(0); // Optional action, depending on your app's behavior
                        }
                      },
                      child: Container(
                        width: 48.0,
                        height: 48.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          // Rounded corners
                          border: Border.all(
                            color: Colors.deepPurple, // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.deepPurple, // Back icon color
                        ),
                      ),
                    ),

                    // Title (conditionally rendered)
                    if (title != null && title!.isNotEmpty)
                      Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center, // Center-align title
                      )
                    else
                      const SizedBox(), // Placeholder if no title

                    // Avatar (conditionally rendered)
                    if (avatarUrl != null && avatarUrl!.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          // Handle avatar click if needed
                        },
                        child: CircleAvatar(
                          radius: 24, // Adjust size
                          backgroundImage: NetworkImage(avatarUrl!),
                          backgroundColor:
                          Colors.grey.shade200,
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade200, // Fallback color
                        child: const Icon(
                          Icons.person, // Placeholder icon
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100); // Adjust height
}
