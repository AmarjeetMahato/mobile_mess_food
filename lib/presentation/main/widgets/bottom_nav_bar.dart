import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mess_food/tabs/home/presentation/pages/home_page.dart';
import 'package:mess_food/tabs/premium/presentation/screens/premium_screen.dart';
import 'package:mess_food/tabs/profile/presentation/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  bool _isVisible = true; // Track visibility
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // Check if user is scrolling down
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) setState(() => _isVisible = false);
      }
      // Check if user is scrolling up
      else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) setState(() => _isVisible = true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Important: Clean up
    super.dispose();
  }

  // Your existing screens
  final List<Widget> appScreen = [
    // const HomePage(), // Replace with HomePage()
    const PremiumScreen(), // Replace with PremiumScreen()
    const ProfileScreen(), // Replace with ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. The Screen Content
          // IMPORTANT: We wrap this in a Theme/Material to avoid the Null check error
          // and ensure the HomePage uses our ScrollController.
          IndexedStack(
            index: _selectedIndex,
            children: [
              // Assuming your HomePage accepts a controller to listen to scrolls
              HomePage(scrollController: _scrollController),
              const PremiumScreen(),
              const ProfileScreen(),
            ],
          ),

          // 2. The Floating Navigation Bar with Animation
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedSlide(
              // When _isVisible is false, it slides down (Offset 1.0 is 100% of height)
              offset: _isVisible ? Offset.zero : const Offset(0, 2),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeInOut,
              child: Container(
                margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      0,
                      FaIcon(
                        FontAwesomeIcons.houseChimney,
                        color: _selectedIndex == 0
                            ? const Color(0xFFFF6B35)
                            : Colors.grey.shade500,
                        size: 20,
                      ),
                      "Menu",
                    ),
                    _buildNavItem(
                      1,
                      FaIcon(
                        FontAwesomeIcons.creditCard,
                        color: _selectedIndex == 1
                            ? const Color(0xFFFF6B35)
                            : Colors.grey.shade500,
                        size: 20,
                      ),
                      "Premium",
                    ),
                    _buildNavItem(
                      2,
                      Icon(
                        FluentSystemIcons.ic_fluent_person_filled,
                        color: _selectedIndex == 2
                            ? const Color(0xFFFF6B35)
                            : Colors.grey.shade500,
                        size: 20,
                      ),
                      "Profile",
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

  // 1. Update the helper method signature
  Widget _buildNavItem(int index, Widget iconWidget, String label) {
    final bool isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        // Adjust padding for a better vertical "bubble" look
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          // Always transparent so no "pill" or "box" appears
          color: Colors.transparent,
          // You can keep the borderRadius or remove it,
          // it won't be visible without a color.
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Essential: wraps the background tightly
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget,
            // We show the text all the time, or only when selected?
            // If you want it exactly like Zomato's footer, we show it always:
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: isSelected
                    ? const Color(0xFFFF6B35)
                    : Colors.grey.shade500,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
