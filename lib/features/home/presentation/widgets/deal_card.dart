import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/product_model.dart';

class DealCard extends StatelessWidget {
  final ProductModel product;

  const DealCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(right: 20),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: product.image,
              height: 400,
              width: 320,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.border.withOpacity(0.3),
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.border.withOpacity(0.3),
                child: const Icon(Icons.image_not_supported_outlined, size: 50),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildCountdown(),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star, color: AppColors.secondary, size: 14),
                        Text(' (${product.rating})', style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text('By ${product.brand}', style: const TextStyle(color: AppColors.textBody, fontSize: 12)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('\$${product.price}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(width: 5),
                            Text('\$${product.oldPrice}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: AppColors.textBody, fontSize: 14)),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryLight,
                            foregroundColor: AppColors.primary,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.shopping_cart_outlined, size: 16),
                              SizedBox(width: 5),
                              Text('Add'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _timerBox('125', 'Days'),
        _timerBox('15', 'Hours'),
        _timerBox('20', 'Mins'),
        _timerBox('05', 'Secs'),
      ],
    );
  }

  Widget _timerBox(String value, String label) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textBody)),
        ],
      ),
    );
  }
}
