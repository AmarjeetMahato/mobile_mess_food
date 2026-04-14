import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

import 'package:mess_food/core/constants/recommanded_data.dart';

class RecommendedMenu extends StatefulWidget {
  const RecommendedMenu({super.key});

  @override
  State<RecommendedMenu> createState() => _RecommendedMenuState();
}

class _RecommendedMenuState extends State<RecommendedMenu>
    with TickerProviderStateMixin {
  // Using a Set to track liked IDs for efficiency
  final Set<String> _likedIds = {};

  // Mapping each ID to its own animation controller
  final Map<String, AnimationController> _controllers = {};

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _toggleLike(String id) {
    // Initialize controller if it doesn't exist
    if (!_controllers.containsKey(id)) {
      _controllers[id] = AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    }

    setState(() {
      if (_likedIds.contains(id)) {
        _likedIds.remove(id);
      } else {
        _likedIds.add(id);
        // Start rotation animation only when liking
        _controllers[id]!.forward(from: 0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemCount: foodItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final item = foodItems[index];
        final bool isLiked = _likedIds.contains(item['id']);

        return GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, '/SinglePage', arguments: item),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .08),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // 🍔 Image Section with Stack
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      child: Image.network(
                        item['image'],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // 🔝 Overlay Info
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                // Price Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.white.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    item['price'],
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Offer Badge
                                if (item['hasOffer'] == true)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFFFF8C00),
                                          Color(0xFFFF6347),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      item['offer'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            // ❤️ Heart Icon
                            GestureDetector(
                              onTap: () => _toggleLike(item['id']),
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: _buildHeartIcon(item['id'], isLiked),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // 🍽️ Meta Info
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. TOP ROW: Title and Rating only
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item['name'],
                              style: GoogleFonts.roboto(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF4B5563),
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Rating Box stays locked to the right
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(
                                alpha: 0.9,
                              ), // Soft white background
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 16,
                                  color: Color(0xFFFFB800),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  item['rating'].toString(),
                                  style: GoogleFonts.outfit(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // 2. DESCRIPTION: Outside the Row, so it takes the full width
                      const SizedBox(
                        height: 8,
                      ), // Gap between Title Row and Description
                      Text(
                        item['desc'] ?? "",
                        softWrap: true,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          height:
                              1.3, // Better line spacing for Jamshedpur foodies to read
                        ),
                      ),

                      // 3. BOTTOM ROW: Time and Distance
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['time'],
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['distance'],
                            style: GoogleFonts.outfit(
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper to build the animated heart
  Widget _buildHeartIcon(String id, bool isLiked) {
    if (!isLiked) {
      return const Icon(Icons.favorite_border, color: Colors.white, size: 28);
    }

    return AnimatedBuilder(
      animation: _controllers[id] ?? kAlwaysDismissedAnimation,
      builder: (context, child) {
        return Transform.rotate(
          angle: (_controllers[id]?.value ?? 0) * 2 * math.pi,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFFFF7E00), Color(0xFFFF3D00)],
            ).createShader(bounds),
            child: const Icon(Icons.favorite, color: Colors.white, size: 28),
          ),
        );
      },
    );
  }
}
