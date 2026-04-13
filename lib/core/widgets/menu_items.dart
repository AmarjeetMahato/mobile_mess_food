import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mess_food/core/constants/categories_data.dart';

class FoodItem {
  final String id;
  final String name;
  final String image;
  FoodItem({required this.id, required this.name, required this.image});
}

class MenuItems extends StatefulWidget {
  const MenuItems({super.key});

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  String selectedId = '1';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110, // Height to accommodate circle + text
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final item = foodItems[index];
          final bool isSelected = selectedId == item.id;

          return GestureDetector(
            onTap: () {
              setState(() => selectedId = item.id);
              // Navigation to separate screen
              Navigator.pushNamed(
                context,
                '/category',
                arguments: {'id': item.id, 'name': item.name},
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? Colors.orange
                            : Colors.grey.shade200,
                        width: isSelected ? 4 : 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.network(item.image, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.name.toUpperCase(), // All Caps for a cleaner UI
                    style: GoogleFonts.montserrat(
                      fontSize: 11, // Slightly smaller for labels
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      letterSpacing: 1.1, // Added "stretch"
                      color: isSelected
                          ? const Color(0xFFFF6B35) // Using your Zesty Orange
                          : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
