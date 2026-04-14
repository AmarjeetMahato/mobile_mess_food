import 'package:flutter/material.dart';
import 'package:mess_food/core/constants/menu_item_data.dart';
import 'package:mess_food/core/widgets/offer_card.dart';

class OfferList extends StatelessWidget {
  const OfferList({super.key});

  @override
  Widget build(BuildContext context) {
    // Pairing logic: count / 2 rounded up
    int columnCount = (offerItems.length / 2).ceil();

    return SizedBox(
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: columnCount,
        itemBuilder: (context, i) {
          int firstIndex = i * 2;
          int secondIndex = i * 2 + 1;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                // First Row Item
                OfferCard(item: offerItems[firstIndex]),
                const SizedBox(height: 12), // Gap-y-3
                // Second Row Item (if it exists)
                if (secondIndex < offerItems.length)
                  OfferCard(item: offerItems[secondIndex])
                else
                  const SizedBox(width: 192), // Placeholder if odd number
              ],
            ),
          );
        },
      ),
    );
  }
}
