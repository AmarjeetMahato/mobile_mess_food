import 'package:flutter/material.dart';
import 'package:mess_food/screens/category/presentation/widgets/build_header.dart';
import 'package:mess_food/screens/category/presentation/widgets/build_title_section.dart';
import 'package:mess_food/screens/category/presentation/widgets/category_data_grid.dart';

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

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = MediaQuery.of(context).size.width * 0.04;
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String categoryImage = args?['image'] ?? "";
    final List<Map<String, String>> data = List.generate(
      18,
      (index) => {
        "id": "$index",
        "title": "Delicious Meal Item $index",
        "image": categoryImage, // Sample Food Image
      },
    );

    // Use a local variable to determine the name
    String displayName = widget.name;

    if (displayName == "Category" && args != null && args.containsKey('name')) {
      displayName = args['name'];
    }
    return Scaffold(
      // <--- 1. Add this
      backgroundColor: Colors.white,
      body: SafeArea(
        // <--- 2. Add this to avoid the notch/status bar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildHeader(categoryName: displayName),
            BuildTitleSection(name: displayName, itemCount: data.length),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: loading
                    ? _buildSkeletonGrid()
                    : CategoryDataGrid(
                        data: data,
                        onItemTap: (item) {
                          print("Clicked on: ${item['title']}");
                          // Navigator.pushNamed(context, '/details', arguments: item);
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonGrid() =>
      const Center(child: CircularProgressIndicator());
}
