import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ContactHeader extends StatelessWidget {
  final bool isMobile;
  const ContactHeader({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('How can help you ?',
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 15),
          Text('Let us know how we can help you',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.',
            style: TextStyle(color: AppColors.textBody, fontSize: 16, height: 1.6),
          ),
        ],
      ),
    );
  }
}
