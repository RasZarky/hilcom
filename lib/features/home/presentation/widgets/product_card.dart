import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../domain/models/product_model.dart';
import '../providers/home_provider.dart';
import '../providers/auth_provider.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  void _handleAction(BuildContext context, VoidCallback action) {
    final auth = context.read<AuthProvider>();
    if (auth.isLoggedIn) {
      action();
    } else {
      context.push('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/product', extra: product),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        errorWidget: (context, url, error) => const Icon(Icons.image_not_supported_outlined, size: 40, color: AppColors.border),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.heading,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: AppColors.secondary, size: 14),
                      Expanded(
                        child: Text(
                          ' (${product.rating})',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'By ${product.brand}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (product.oldPrice != null)
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'GH₵ ${product.oldPrice}',
                                  style: const TextStyle(
                                    color: AppColors.textBody,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'GH₵ ${product.price}',
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () => _handleAction(context, () {
                          context.read<HomeProvider>().addToCart(product);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.title} added to cart'),
                              duration: const Duration(seconds: 3),
                              showCloseIcon: true,
                              action: SnackBarAction(
                                label: 'View Cart',
                                onPressed: () => context.push('/cart'),
                              ),
                            ),
                          );
                        }),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.add, color: AppColors.primary, size: 18),
                        ),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getBadgeColor(product.badge!),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Text(
                    product.badge!,
                    style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            Positioned(
              top: 8,
              right: 8,
              child: Consumer<HomeProvider>(
                builder: (context, provider, _) {
                  final isInWishlist = provider.isInWishlist(product);
                  return InkWell(
                    onTap: () => _handleAction(context, () => provider.toggleWishlist(product)),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        isInWishlist ? Icons.favorite : Icons.favorite_border,
                        color: isInWishlist ? Colors.red : AppColors.textBody,
                        size: 18,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
