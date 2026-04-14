import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTitleSection extends StatelessWidget {
  final String name;
  final int itemCount;

  const BuildTitleSection({
    super.key,
    required this.name,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            name,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "( $itemCount items available )",
            style: GoogleFonts.outfit(
              fontSize: 13,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
