import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final notificationCount = 10;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spreads content
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Amar Mahato",
              style: GoogleFonts.montserrat(
                // Same family, but Title Case
                fontSize: 18,
                fontWeight: FontWeight.w700, // Bold but not "heavy"
                color: const Color(0xFF1F2937),
                letterSpacing:
                    -0.2, // Slight tight spacing for names looks sleek
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  LineIcons.mapMarker,
                  size: 14,
                  color: Colors.grey[600],
                ), // Small location icon
                const SizedBox(width: 4),
                Text(
                  "${"NH-18, Dalma Base Colony, Jamshedpur".substring(0, 30)}...",
                  style: GoogleFonts.outfit(
                    // Using Outfit here for a slightly softer feel
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
        // Maybe an Avatar or Notification icon on the right?
        Row(
          children: [
            // 1. Search Button
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/auth'),
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Transform.scale(
                  scaleX: -1, // Flips horizontally
                  child: const Icon(
                    LineIcons.search,
                    size: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // 2. Notification Button with Badge
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/notifications'),
              borderRadius: BorderRadius.circular(50),
              child: Stack(
                clipBehavior: Clip.none, // Allows badge to overlap
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.bell,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),

                  // Notification Badge Logic
                  if (notificationCount > 0)
                    Positioned(
                      top: -5,
                      right: -2,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6B35), // Zesty Orange
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            '10',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
