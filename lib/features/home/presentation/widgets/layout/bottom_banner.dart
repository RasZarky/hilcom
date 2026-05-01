import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class BottomBanner extends StatelessWidget {
  final bool isMobile;
  const BottomBanner({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 15 : 50),
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1200&auto=format&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Stay home & get your daily\nneeds from our shop',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.heading),
          ),
          const SizedBox(height: 20),
          const Text('Start Your Daily Shopping with Hilcom Mart', style: TextStyle(fontSize: 18, color: AppColors.textBody)),
          const SizedBox(height: 30),
          if (!isMobile)
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(25)),
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  const Expanded(child: TextField(decoration: InputDecoration(hintText: 'Your email address', border: InputBorder.none))),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(25)),
                    alignment: Alignment.center,
                    child: const Text('Subscribe', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
