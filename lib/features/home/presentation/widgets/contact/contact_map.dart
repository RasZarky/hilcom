import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ContactMap extends StatelessWidget {
  final bool isMobile;
  const ContactMap({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200],
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1?q=80&w=1200&auto=format&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: const Icon(Icons.location_on, color: AppColors.primary, size: 40),
        ),
      ),
    );
  }
}
