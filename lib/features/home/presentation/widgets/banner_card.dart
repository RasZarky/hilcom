import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';

class BannerCard extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final VoidCallback? onTap;

  const BannerCard({
    super.key,
    required this.title,
    required this.image,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 240,
        constraints: const BoxConstraints(minWidth: 300),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Image/Illustration
            Positioned(
              top: -10,
              right: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.9,
                child: CachedNetworkImage(
                  imageUrl: image,
                  height: 160,
                  width: 160,
                  fit: BoxFit.contain,
                  errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.heading,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Material(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                    child: InkWell(
                      onTap: onTap ?? () {},
                      borderRadius: BorderRadius.circular(4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Shop Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
