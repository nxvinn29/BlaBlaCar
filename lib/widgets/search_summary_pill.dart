import 'package:flutter/material.dart';

class SearchSummaryPill extends StatelessWidget {
  final String routeText;
  final String detailsText;
  final VoidCallback? onFilter;

  const SearchSummaryPill(
      {super.key,
      required this.routeText,
      required this.detailsText,
      this.onFilter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(routeText,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(detailsText, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          TextButton(onPressed: onFilter, child: const Text('Filter'))
        ],
      ),
    );
  }
}
