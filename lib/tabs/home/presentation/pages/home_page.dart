import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mess_food/core/widgets/menu_items.dart';
import 'package:mess_food/tabs/home/presentation/widgets/navbar.dart';
import 'package:mess_food/tabs/home/presentation/widgets/offer_list.dart';
import 'package:mess_food/features/recommanded/presentation/widgets/recommanded_menu.dart';

class HomePage extends StatefulWidget {
  final ScrollController scrollController;
  const HomePage({super.key, required this.scrollController});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double horizontalPadding = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: widget.scrollController,
          // Safe to use here now because there is no Expanded inside
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Navbar
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 10,
                ),
                child: const Navbar(),
              ),

              const SizedBox(height: 12),

              // 2. Menu Items (The Horizontal List)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  "Categories"
                      .toUpperCase(), // "Explore" adds a better UX "Call to Action"
                  style: GoogleFonts.montserrat(
                    // Using Poppins
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(
                      255,
                      105,
                      105,
                      106,
                    ), // Darker gray for premium feel
                    letterSpacing: 1, // Tighter spacing looks more modern
                  ),
                ),
              ),
              const SizedBox(height: 12), // Space between title and list

              const MenuItems(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  "Today's Offers".toUpperCase(), // Makes all text CAPITAL
                  style: GoogleFonts.montserrat(
                    // Closest to Zomato's brand font
                    fontSize:
                        14, // Section headers in pro apps are often 14-16 but bold
                    fontWeight:
                        FontWeight.w600, // Extra bold for that "Zomato" impact
                    letterSpacing: 1, // This adds the "stretch" you asked for
                    color: const Color.fromARGB(
                      255,
                      105,
                      105,
                      106,
                    ), // Deep Charcoal
                  ),
                ),
              ),

              SizedBox(height: 12),

              OfferList(),

              SizedBox(height: 12),

              // 3. Other Content (Recommended, Offers, etc.)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  "Recommended for You".toUpperCase(), // Makes all text CAPITAL
                  style: GoogleFonts.montserrat(
                    // Closest to Zomato's brand font
                    fontSize:
                        14, // Section headers in pro apps are often 14-16 but bold
                    fontWeight:
                        FontWeight.w500, // Extra bold for that "Zomato" impact
                    letterSpacing: 1, // This adds the "stretch" you asked for
                    color: const Color.fromARGB(
                      255,
                      105,
                      105,
                      106,
                    ), // Deep Charcoal
                  ),
                ),
              ),

              const SizedBox(height: 12),

              RecommendedMenu(),
            ],
          ),
        ),
      ),
    );
  }
}
