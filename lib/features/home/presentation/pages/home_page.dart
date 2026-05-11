import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/home_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/product_card.dart';
import '../widgets/deal_card.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/web_secondary_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/mobile_drawer.dart';
import '../widgets/layout/footer.dart';
import '../widgets/layout/bottom_banner.dart';
import 'package:hilcom/core/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _handleAddToCart(BuildContext context, dynamic product) {
    final auth = context.read<AuthProvider>();
    if (auth.isLoggedIn) {
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
    } else {
      context.push('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            final hasSearch = provider.searchQuery.isNotEmpty;
            
            return Column(
              children: [
                // Add spacing for the floating app bar
                SizedBox(height: isMobile ? 110 : 120),
                if (!isMobile) const WebSecondaryHeader(currentPage: 'Home'),
                
                if (hasSearch)
                  _buildSearchResults(context, provider, isMobile)
                else ...[
                  _buildCategorySection(context, isMobile),
                  _buildProductSection(context, isMobile),
                  _buildDailyBestSells(context, isMobile),
                  _buildDealsOfTheDay(context, isMobile),
                  _buildProductLists(context, isMobile),
                  BottomBanner(isMobile: isMobile),
                  _buildFeatureIcons(context, isMobile),
                ],
                Footer(isMobile: isMobile),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchResults(BuildContext context, HomeProvider provider, bool isMobile) {
    final results = provider.filteredProducts;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Search Results for "${provider.searchQuery}"',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 24 : 32,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => provider.setSearchQuery(''),
                child: const Text('Clear Search'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${results.length} items found',
            style: const TextStyle(color: AppColors.textBody),
          ),
          const SizedBox(height: 30),
          if (results.isEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 80, color: AppColors.border),
                  const SizedBox(height: 20),
                  Text(
                    'No products found matching your search.',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 2 : 5,
                childAspectRatio: 0.7,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ProductCard(product: results[index]);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'EXPLORE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Featured Categories',
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: isMobile ? 28 : 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        color: AppColors.heading,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 220,
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(category: provider.categories[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection(BuildContext context, bool isMobile) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Popular Products',
                  style: Theme.of(context).textTheme.displayMedium),
              const Spacer(),
              const Text('All Products', style: TextStyle(color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 30),
          Consumer<HomeProvider>(
            builder: (context, provider, _) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 2 : 5,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: provider.popularProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(product: provider.popularProducts[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDailyBestSells(BuildContext context, bool isMobile) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daily Best Sells',
              style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMobile)
                Container(
                  width: 300,
                  height: 450,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1524758631624-e2822e304c36?q=80&w=300&auto=format&fit=crop'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: const Text(
                    'Upgrade Your\nLifestyle\nToday',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.heading),
                  ),
                ),
              const SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  height: 450,
                  child: Consumer<HomeProvider>(
                    builder: (context, provider, _) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: provider.dealsOfTheDay.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: isMobile ? 220 : 280,
                            margin: const EdgeInsets.only(right: 15),
                            child: ProductCard(
                                product: provider.dealsOfTheDay[index]),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDealsOfTheDay(BuildContext context, bool isMobile) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Deals Of The Day',
              style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 30),
          SizedBox(
            height: 450, // Increased height to prevent clipping
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: provider.dealsOfTheDay.length,
                  itemBuilder: (context, index) {
                    return DealCard(product: provider.dealsOfTheDay[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductLists(BuildContext context, bool isMobile) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 40),
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          if (isMobile) {
            return Column(
              children: provider.listProducts.entries
                  .map((e) => _buildSmallProductList(context, e.key, e.value))
                  .toList(),
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: provider.listProducts.entries
                .map((e) => Expanded(child: _buildSmallProductList(context, e.key, e.value)))
                .toList(),
          );
        },
      ),
    );
  }

  Widget _buildSmallProductList(BuildContext context, String title, List<dynamic> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.heading)),
          const SizedBox(height: 10),
          const Divider(thickness: 2, color: AppColors.primaryLight),
          const SizedBox(height: 20),
          ...products.map((p) => InkWell(
                onTap: () => context.push('/product', extra: p),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(p.image,
                            width: 80, height: 80, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    const TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: AppColors.secondary, size: 14),
                                Text(' (${p.rating})',
                                    style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('GH₵ ${p.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                InkWell(
                                  onTap: () => _handleAddToCart(context, p),
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
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildFeatureIcons(BuildContext context, bool isMobile) {
    final features = [
      {
        'icon': Icons.sell_outlined,
        'title': 'Best prices & offers',
        'subtitle': 'Orders GH₵ 50 or more'
      },
      {
        'icon': Icons.local_shipping_outlined,
        'title': 'Free delivery',
        'subtitle': '24/7 help center'
      },
      {
        'icon': Icons.verified_user_outlined,
        'title': 'Great daily deal',
        'subtitle': 'When you sign up'
      },
      {
        'icon': Icons.refresh_outlined,
        'title': 'Easy returns',
        'subtitle': 'Within 30 days'
      },
      {
        'icon': Icons.headset_mic_outlined,
        'title': 'Support 24/7',
        'subtitle': 'Shop with confidence'
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 15 : 50,
        vertical: 40,
      ),
      child: isMobile
          ? Column(
              children: features
                  .map((f) => _buildFeatureItem(f, true))
                  .toList(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: features
                  .map((f) => Expanded(child: _buildFeatureItem(f, false)))
                  .toList(),
            ),
    );
  }

  Widget _buildFeatureItem(Map<String, dynamic> feature, bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 10 : 5),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(feature['icon'] as IconData, size: 40, color: AppColors.primary),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.heading,
                  ),
                ),
                Text(
                  feature['subtitle'] as String,
                  style: const TextStyle(
                    color: AppColors.textBody,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
