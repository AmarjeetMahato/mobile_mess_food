import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CategoryScreen extends StatefulWidget {
  final String name; // Pass the category name from Home
  const CategoryScreen({super.key, this.name = "Category"});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  bool isSearchFocused = false;
  bool loading = false; // Toggle this to see the skeleton effect
  String searchText = "";
  final List<Map<String, String>> data = List.generate(
    12,
    (index) => {
      "id": "$index",
      "title": "Delicious Meal Item $index",
      "image":
          "https://images.unsplash.com/photo-1546069901-ba9599a7e63c", // Sample Food Image
    },
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildTitleSection(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: loading ? _buildSkeletonGrid() : _buildDataGrid(),
          ),
        ),
      ],
    );
  }

  // --- 1. THE MODERN HEADER ---
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 20,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Search Bar
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: isSearchFocused ? Colors.white : const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: isSearchFocused
                      ? const Color(0xFFFF6B35)
                      : Colors.transparent,
                ),
                boxShadow: [
                  if (isSearchFocused)
                    BoxShadow(
                      color: const Color(0xFFFF6B35).withOpacity(0.12),
                      blurRadius: 6,
                      offset: const Offset(0, 1),
                    ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    LineIcons.search,
                    size: 20,
                    color: isSearchFocused
                        ? const Color(0xFFFF6B35)
                        : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      onChanged: (val) => setState(() => searchText = val),
                      onTap: () => setState(() => isSearchFocused = true),
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                        setState(() => isSearchFocused = false);
                      },
                      decoration: InputDecoration(
                        hintText: "Search in ${widget.name}...",
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  if (searchText.isNotEmpty)
                    GestureDetector(
                      onTap: () => setState(() => searchText = ""),
                      child: const Icon(
                        Icons.cancel,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 2. TITLE SECTION ---
  Widget _buildTitleSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "( ${data.length} items available )",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  // --- 3. DATA GRID ---
  Widget _buildDataGrid() {
    if (data.isEmpty) return _buildEmptyState();
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75, // Adjust for card height
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final item = data[index];
        return GestureDetector(
          onTap: () {}, // Navigate to single page
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    item['image']!,
                    height: 80,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item['title']!,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() =>
      const Center(child: Icon(LineIcons.search, size: 64, color: Colors.grey));
  Widget _buildSkeletonGrid() =>
      const Center(child: CircularProgressIndicator());
}
