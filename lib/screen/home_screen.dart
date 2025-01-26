import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:project/components/sunrise_sunset.dart';
import 'package:project/components/timeline/timeline_comp.dart';
import 'package:project/components/top_bar.dart';
import 'package:project/providers/auth_provider.dart';
import 'package:project/providers/go_router.dart';

// Define a provider for the selected tab index
final selectedTabProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of pages corresponding to the tabs
    final List<Widget> pages = [
      Column(
        children: [
          TopBar(),
          TaskTimeline(),
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(width: double.infinity, child: MovingWave()),
      ),
      Center(child: Consumer(
        builder: (context, ref, child) {
          return ElevatedButton(
            onPressed: () async {
              await ref.read(authServiceProvider.notifier).signOut();
              ref.read(navigationProvider).go('/');
            },
            child: Text('Logout'),
          );
        },
      )),
      Center(child: Consumer(builder: (context, ref, child){
        final navigationService = ref.read(navigationProvider);
        final authStateService = ref.read(authStateProvider);

        return GestureDetector(
          onTap: () async {
            await ref.read(authServiceProvider.notifier).signOut();
            navigationService.router.go('/login');
          },
          child: Text('null ${authStateService.value == null}'),
        );
      })),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          // Get the current selected tab index
          final selectedIndex = ref.watch(selectedTabProvider);
          return pages[selectedIndex];
        },
      ),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          // Get the current selected tab index
          final selectedIndex = ref.watch(selectedTabProvider);

          return BottomNavyBar(
            selectedIndex: selectedIndex,
            showElevation: true,
            containerHeight: 70,

            onItemSelected: (index) {
              // Update the selected tab index
              ref.read(selectedTabProvider.notifier).state = index;
            },
            items: [
              BottomNavyBarItem(
                icon: _buildIconWithBackground(
                    context, Icons.home, selectedIndex == 0),
                title: const Text('Home'),
                activeColor: Colors.deepPurple,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                icon: _buildIconWithBackground(
                    context, Icons.calendar_month_outlined, selectedIndex == 1),
                title: const Text('Calendar'),
                activeColor: Colors.deepPurple,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                icon: _buildIconWithBackground(
                    context, Icons.search, selectedIndex == 2),
                title: const Text('Tasks'),
                activeColor: Colors.deepPurple,
                inactiveColor: Colors.grey,
              ),
              BottomNavyBarItem(
                icon: _buildIconWithBackground(
                    context, Icons.person, selectedIndex == 3),
                title: const Text('Profile'),
                activeColor: Colors.deepPurple,
                inactiveColor: Colors.grey,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIconWithBackground(
    BuildContext context,
    IconData icon,
    bool isActive,
  ) {
    // Get the width of the screen
    final screenWidth = MediaQuery.of(context).size.width;

    // Dynamically calculate size based on the screen width
    final size = screenWidth * 0.08; // 8% of screen width

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? Colors.transparent : Colors.grey[200],
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: isActive ? Colors.purple : Colors.grey,
        size: size * 0.625, // Icon size is 62.5% of the container
      ),
    );
  }
}
