import 'package:flutter/material.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/features/home/domain/models/product_model.dart';

class ProductInfoSection extends StatelessWidget {
  final ProductModel product;
  final bool isMobile;

  const ProductInfoSection({
    super.key,
    required this.product,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (product.badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.badgeSale.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              product.badge!,
              style: const TextStyle(
                  color: AppColors.badgeSale, fontWeight: FontWeight.bold),
            ),
          ),
        const SizedBox(height: 15),
        Text(
          product.title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: isMobile ? 28 : 40,
                color: AppColors.heading,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Row(
              children: List.generate(
                  5,
                  (index) => Icon(
                        index < product.rating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.secondary,
                        size: 18,
                      )),
            ),
            const SizedBox(width: 8),
            Text('(${product.rating} reviews)',
                style: const TextStyle(color: AppColors.textBody)),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'GH₵ ${product.price}',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 20),
            if (product.oldPrice != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('26% Off',
                      style: TextStyle(
                          color: AppColors.badgeHot,
                          fontWeight: FontWeight.bold)),
                  Text(
                    'GH₵ ${product.oldPrice}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: AppColors.textBody,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam ac dui sed nunc sagittis rhoncus at a mi. Aliquam hendrerit pulvinar mollis. Donec ut sem.',
          style: TextStyle(color: AppColors.textBody, fontSize: 16, height: 1.6),
        ),
        const SizedBox(height: 30),
        const Text('Size / Weight:',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBody)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: [
            _buildSizeOption('50g', false),
            _buildSizeOption('60g', true),
            _buildSizeOption('80g', false),
            _buildSizeOption('100g', false),
            _buildSizeOption('150g', false),
          ],
        ),
        const SizedBox(height: 35),
        Row(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  const Text('1',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.keyboard_arrow_up, size: 16),
                      Icon(Icons.keyboard_arrow_down, size: 16),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_outlined),
                label: const Text('Add to cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(width: 15),
              _buildActionIcon(Icons.favorite_border),
              const SizedBox(width: 10),
              _buildActionIcon(Icons.refresh),
            ],
          ],
        ),
        if (isMobile) ...[
          const SizedBox(height: 15),
          Row(
            children: [
              _buildActionIcon(Icons.favorite_border),
              const SizedBox(width: 10),
              _buildActionIcon(Icons.refresh),
              const SizedBox(width: 10),
              const Text('Add to wishlist', style: TextStyle(color: AppColors.textBody)),
            ],
          ),
        ],
        const SizedBox(height: 40),
        const Divider(),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetaInfo('Type:', 'Organic'),
                  _buildMetaInfo('MFG:', 'Jun 4, 2024'),
                  _buildMetaInfo('Stock:', '8 Items In Stock'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetaInfo('SKU:', 'FWM15VK'),
                  _buildMetaInfo('Tags:', 'Snack, Organic, Brown'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeOption(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.textBody,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(icon, color: AppColors.textBody, size: 20),
    );
  }

  Widget _buildMetaInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(label, style: const TextStyle(color: AppColors.textBody)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
