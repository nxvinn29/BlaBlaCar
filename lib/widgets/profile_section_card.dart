import 'package:flutter/material.dart';

class ProfileSectionCard extends StatelessWidget {
  final Widget child;
  const ProfileSectionCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(padding: const EdgeInsets.all(12.0), child: child),
    );
  }
}
