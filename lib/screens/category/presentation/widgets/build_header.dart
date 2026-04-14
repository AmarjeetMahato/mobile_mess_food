import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BuildHeader extends StatefulWidget {
  final String categoryName;
  final ValueChanged<String>? onSearchChanged;

  const BuildHeader({
    super.key,
    required this.categoryName,
    this.onSearchChanged,
  });

  @override
  State<BuildHeader> createState() => _BuildHeaderState();
}

class _BuildHeaderState extends State<BuildHeader> {
  bool isSearchFocused = false;
  String searchText = "";
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // --- Back Button ---
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
                    color: Colors.black.withValues(alpha: 0.08),
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

          // --- Search Bar ---
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
                      color: const Color(0xFFFF6B35).withValues(alpha: 0.12),
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
                      controller: _controller,
                      onChanged: (val) {
                        setState(() => searchText = val);
                        if (widget.onSearchChanged != null) {
                          widget.onSearchChanged!(val);
                        }
                      },
                      onTap: () => setState(() => isSearchFocused = true),
                      onTapOutside: (_) {
                        FocusScope.of(context).unfocus();
                        setState(() => isSearchFocused = false);
                      },
                      decoration: InputDecoration(
                        hintText: "Search in ${widget.categoryName}...",
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
                      onTap: () {
                        setState(() => searchText = "");
                        _controller.clear();
                        if (widget.onSearchChanged != null) {
                          widget.onSearchChanged!("");
                        }
                      },
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
}
