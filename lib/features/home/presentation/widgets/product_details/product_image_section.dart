import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ProductImageSection extends StatelessWidget {
  final String image;
  final bool isMobile;
  const ProductImageSection({super.key, required this.image, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(15),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.contain,
            width: double.infinity,
            height: isMobile ? 300 : 500,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (index) {
            return Container(
              width: isMobile ? 70 : 100,
              height: isMobile ? 70 : 100,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.contain,
              ),
            );
          }),
        ),
      ],
    );
  }
}
