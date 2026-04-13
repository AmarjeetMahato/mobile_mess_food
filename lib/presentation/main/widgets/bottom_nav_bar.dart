import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mess_food/features/home/presentation/pages/home_page.dart';
import 'package:mess_food/features/premium/presentation/screens/premium_screen.dart';
import 'package:mess_food/features/profile/presentation/screens/profile_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  final appScreen = [HomePage(), PremiumScreen(), ProfileScreen()];

  // Change our Index for BottomNavbar
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appScreen[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 52,
        child: BottomNavigationBar(
          iconSize: 22,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          // --- ZESTY SUNSET COLORS ---
          selectedItemColor: const Color(0xFFFF6B35), // Primary Orange
          unselectedItemColor: const Color.fromARGB(
            255,
            71,
            72,
            86,
          ), // Dark Navy Grey (Eye-friendly)
          backgroundColor: const Color(0xFFFDFDFF), // Clean Off-White
          type: BottomNavigationBarType.fixed, // Keeps background consistent
          showSelectedLabels: false,
          showUnselectedLabels: false,
          // Use height to pull the text closer (1.0 is tight, 1.5 is standard)
          selectedLabelStyle: const TextStyle(height: 1, fontSize: 12),
          unselectedLabelStyle: const TextStyle(height: 1, fontSize: 12),

          // --- ICON SIZE ANIMATION ---
          unselectedIconTheme: const IconThemeData(
            size: 22, // Standard size when not selected
          ),
          items: [
            BottomNavigationBarItem(
              // Use FaIcon wrapper for better alignment with FontAwesome
              icon: FaIcon(FontAwesomeIcons.houseChimney),
              // FontAwesome usually uses 'solid' for the active/filled state
              activeIcon: FaIcon(FontAwesomeIcons.houseChimney),
              label: "",
            ),
            // 2. Premium Tab (Using a Diamond/Crown for a more "Elite" feel)
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.creditCard),
              activeIcon: FaIcon(FontAwesomeIcons.creditCard),
              label: "",
            ),

            // 3. Profile Tab (Using a Circle-User for a modern UI)
            BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_person_filled),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
