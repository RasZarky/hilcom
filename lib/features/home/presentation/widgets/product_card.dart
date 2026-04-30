import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/models/product_model.dart';
import '../../../../core/theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.border),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                      errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined, size: 50, color: AppColors.border),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  product.category,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5),
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.heading,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.secondary, size: 16),
                    Text(' (${product.rating})', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  'By ${product.brand}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.primary),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        if (product.oldPrice != null) ...[
                          const SizedBox(width: 5),
                          Text(
                            '\$${product.oldPrice}',
                            style: const TextStyle(
                              color: AppColors.textBody,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(Icons.add, color: AppColors.primary, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (product.badge != null)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  color: _getBadgeColor(product.badge!),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                child: Text(
                  product.badge!,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _getBadgeColor(String badge) {
    switch (badge.toLowerCase()) {
      case 'hot': return AppColors.badgeHot;
      case 'new': return AppColors.badgeNew;
      case 'sale': return AppColors.badgeSale;
      default: return AppColors.primary;
    }
  }
}
