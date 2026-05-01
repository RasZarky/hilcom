import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ContactInfoGrid extends StatelessWidget {
  final bool isMobile;
  const ContactInfoGrid({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': '01. Visit Feedback',
        'desc': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.'
      },
      {
        'title': '02. Employer Services',
        'desc': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.'
      },
      {
        'title': '03. Billing inquiries',
        'desc': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.'
      },
      {
        'title': '04. General Inquiries',
        'desc': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.'
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 50, vertical: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 1 : 2,
          childAspectRatio: isMobile ? 2.5 : 3.5,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(items[index]['title']!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.heading)),
              const SizedBox(height: 10),
              Text(items[index]['desc']!,
                  style: const TextStyle(color: AppColors.textBody, height: 1.5)),
            ],
          );
        },
      ),
    );
  }
}
