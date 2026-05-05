import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../providers/home_provider.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/mobile_drawer.dart';
import '../widgets/layout/footer.dart';
import '../widgets/product_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 900;
    final isTablet = size.width >= 900 && size.width < 1200;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFD),
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // Sleek Header Section
              SliverToBoxAdapter(
                child: _buildHeader(context, provider, isMobile),
              ),

              // Wishlist Content
              if (provider.wishlistItems.isEmpty)
                SliverToBoxAdapter(
                  child: _buildEmptyWishlist(context, provider, isMobile),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 15 : 50,
                    vertical: 20,
                  ),
                  sliver: _buildWishlistGrid(provider, isMobile, isTablet),
                ),

              // Recommended Products (Shows always, but highlighted when empty)
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 15 : 50,
                  vertical: 40,
                ),
                sliver: SliverToBoxAdapter(
                  child: _buildRecommendedSection(context, provider, isMobile),
                ),
              ),

              // Footer
              SliverToBoxAdapter(
                child: Footer(isMobile: isMobile),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, HomeProvider provider, bool isMobile) {
    return Container(
      padding: EdgeInsets.only(
        top: isMobile ? 20 : 140, 
        bottom: 30,
        left: isMobile ? 20 : 50,
        right: isMobile ? 20 : 50,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary.withOpacity(0.08),
            const Color(0xFFFBFBFD),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, size: 14, color: AppColors.primary),
                SizedBox(width: 6),
                Text(
                  'SAVED FOR LATER',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Wishlist',
                      style: TextStyle(
                        fontSize: isMobile ? 36 : 56,
                        fontWeight: FontWeight.w900,
                        color: AppColors.heading,
                        letterSpacing: -1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      provider.wishlistItems.isEmpty
                          ? 'Start adding items you love'
                          : '${provider.wishlistCount} items meticulously selected by you',
                      style: TextStyle(
                        color: AppColors.textBody.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              if (provider.wishlistItems.isNotEmpty)
                _buildActionButtons(context, provider, isMobile),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, HomeProvider provider, bool isMobile) {
    return Row(
      children: [
        if (!isMobile)
          TextButton.icon(
            onPressed: () {
              provider.addAllToCart(provider.wishlistItems);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Everything moved to your cart!'),
                  backgroundColor: AppColors.primary,
                ),
              );
            },
            icon: const Icon(Icons.add_shopping_cart_rounded, size: 20),
            label: const Text('Add All to Cart'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.primary.withOpacity(0.2)),
              ),
            ),
          ),
        const SizedBox(width: 12),
        IconButton.filledTonal(
          onPressed: () => _showClearDialog(context, provider),
          icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
          style: IconButton.styleFrom(
            backgroundColor: Colors.red.withOpacity(0.05),
            padding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyWishlist(BuildContext context, HomeProvider provider, bool isMobile) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(vertical: 60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          const Icon(Icons.favorite_outline_rounded, size: 80, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 20),
          const Text(
            'Your wishlist is empty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.heading),
          ),
          const SizedBox(height: 10),
          const Text(
            'Save items to keep track of what you love.',
            style: TextStyle(color: AppColors.textBody),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => context.go('/'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 0,
            ),
            child: const Text('Discover Products', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistGrid(HomeProvider provider, bool isMobile, bool isTablet) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 5),
        crossAxisSpacing: isMobile ? 15 : 25,
        mainAxisSpacing: isMobile ? 15 : 25,
        childAspectRatio: isMobile ? 0.65 : 0.72,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = provider.wishlistItems[index];
          return TweenAnimationBuilder<double>(
            duration: Duration(milliseconds: 300 + (index * 100)),
            tween: Tween(begin: 0.0, end: 1.0),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: ProductCard(product: product),
          );
        },
        childCount: provider.wishlistItems.length,
      ),
    );
  }

  Widget _buildRecommendedSection(BuildContext context, HomeProvider provider, bool isMobile) {
    final recommendations = provider.popularProducts.take(4).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommended for you',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.heading),
            ),
            TextButton(
              onPressed: () => context.go('/'),
              child: const Text('View All', style: TextStyle(color: AppColors.primary)),
            ),
          ],
        ),
        const SizedBox(height: 25),
        isMobile
            ? SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendations.length,
                  itemBuilder: (context, index) => Container(
                    width: 200,
                    margin: const EdgeInsets.only(right: 15),
                    child: ProductCard(product: recommendations[index]),
                  ),
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  childAspectRatio: 0.72,
                ),
                itemCount: recommendations.length,
                itemBuilder: (context, index) => ProductCard(product: recommendations[index]),
              ),
      ],
    );
  }

  void _showClearDialog(BuildContext context, HomeProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Clear Wishlist?'),
        content: const Text('This will remove all items. You can\'t undo this action.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textBody)),
          ),
          ElevatedButton(
            onPressed: () {
              provider.clearWishlist();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, elevation: 0),
            child: const Text('Clear All', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
