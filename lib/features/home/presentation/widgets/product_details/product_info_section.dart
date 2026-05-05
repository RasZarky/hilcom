import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import 'package:hilcom/features/home/domain/models/product_model.dart';
import '../../providers/home_provider.dart';
import '../../providers/auth_provider.dart';

class ProductInfoSection extends StatefulWidget {
  final ProductModel product;
  final bool isMobile;

  const ProductInfoSection({
    super.key,
    required this.product,
    required this.isMobile,
  });

  @override
  State<ProductInfoSection> createState() => _ProductInfoSectionState();
}

class _ProductInfoSectionState extends State<ProductInfoSection> {
  int _quantity = 1;
  String _selectedSize = '60g';

  final List<String> _sizeOptions = ['50g', '60g', '80g', '100g', '150g'];

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.product.badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.badgeSale.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              widget.product.badge!,
              style: const TextStyle(
                  color: AppColors.badgeSale, fontWeight: FontWeight.bold),
            ),
          ),
        const SizedBox(height: 15),
        Text(
          widget.product.title,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontSize: widget.isMobile ? 28 : 40,
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
                        index < widget.product.rating.floor()
                            ? Icons.star
                            : Icons.star_border,
                        color: AppColors.secondary,
                        size: 18,
                      )),
            ),
            const SizedBox(width: 8),
            Text('(${widget.product.rating} reviews)',
                style: const TextStyle(color: AppColors.textBody)),
          ],
        ),
        const SizedBox(height: 25),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'GH₵ ${widget.product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 20),
            if (widget.product.oldPrice != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('26% Off',
                      style: TextStyle(
                          color: AppColors.badgeHot,
                          fontWeight: FontWeight.bold)),
                  Text(
                    'GH₵ ${widget.product.oldPrice?.toStringAsFixed(2)}',
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
          'Experience premium quality with this item. Carefully sourced and built to last, it brings both style and functionality to your lifestyle. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          style: TextStyle(color: AppColors.textBody, fontSize: 16, height: 1.6),
        ),
        const SizedBox(height: 30),
        const Text('Size / Weight:',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textBody)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: _sizeOptions.map((size) => _buildSizeOption(size)).toList(),
        ),
        const SizedBox(height: 35),
        Row(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.5)),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: Text('$_quantity',
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => setState(() => _quantity++),
                        child: const Icon(Icons.keyboard_arrow_up, size: 20, color: AppColors.primary),
                      ),
                      InkWell(
                        onTap: () {
                          if (_quantity > 1) {
                            setState(() => _quantity--);
                          }
                        },
                        child: const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _handleAction(context, () {
                  context.read<HomeProvider>().addToCart(widget.product, quantity: _quantity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${widget.product.title} added to cart'),
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'View Cart',
                        onPressed: () => context.push('/cart'),
                      ),
                    ),
                  );
                }),
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
            if (!widget.isMobile) ...[
              const SizedBox(width: 15),
              _buildWishlistButton(),
              const SizedBox(width: 10),
              _buildActionIcon(Icons.refresh),
            ],
          ],
        ),
        if (widget.isMobile) ...[
          const SizedBox(height: 15),
          Row(
            children: [
              _buildWishlistButton(),
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
                  _buildMetaInfo('Type:', widget.product.category),
                  _buildMetaInfo('MFG:', 'Jun 4, 2024'),
                  _buildMetaInfo('Stock:', '8 Items In Stock'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetaInfo('SKU:', 'HIL-${widget.product.brand.toUpperCase().substring(0, 3)}'),
                  _buildMetaInfo('Tags:', 'Premium, Featured, New'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeOption(String label) {
    bool isSelected = _selectedSize == label;
    return InkWell(
      onTap: () => setState(() => _selectedSize = label),
      child: Container(
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
      ),
    );
  }

  Widget _buildWishlistButton() {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        final isInWishlist = provider.isInWishlist(widget.product);
        return InkWell(
          onTap: () => _handleAction(context, () => provider.toggleWishlist(widget.product)),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: isInWishlist ? AppColors.primary : AppColors.border),
              borderRadius: BorderRadius.circular(5),
              color: isInWishlist ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
            ),
            child: Icon(
              isInWishlist ? Icons.favorite : Icons.favorite_border,
              color: isInWishlist ? Colors.red : AppColors.textBody,
              size: 20,
            ),
          ),
        );
      },
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
