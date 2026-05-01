import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ContactLocations extends StatelessWidget {
  final bool isMobile;
  const ContactLocations({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final locations = [
      {
        'title': 'Office',
        'address': '205 North Michigan Avenue, Suite 810\nChicago, 60601, USA\nPhone: (123) 456-7890\nEmail: contact@hilcom.com'
      },
      {
        'title': 'Studio',
        'address': '205 North Michigan Avenue, Suite 810\nChicago, 60601, USA\nPhone: (123) 456-7890\nEmail: contact@hilcom.com'
      },
      {
        'title': 'Shop',
        'address': '205 North Michigan Avenue, Suite 810\nChicago, 60601, USA\nPhone: (123) 456-7890\nEmail: contact@hilcom.com'
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 40),
      child: isMobile
          ? Column(children: locations.map((l) => _buildLocationItem(l)).toList())
          : Row(
              children: locations
                  .map((l) => Expanded(child: _buildLocationItem(l)))
                  .toList()),
    );
  }

  Widget _buildLocationItem(Map<String, String> location) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(location['title']!,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary)),
          const SizedBox(height: 15),
          Text(location['address']!,
              style: const TextStyle(color: AppColors.textBody, height: 1.6)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.map_outlined, size: 18),
            label: const Text('View map'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
        ],
      ),
    );
  }
}
