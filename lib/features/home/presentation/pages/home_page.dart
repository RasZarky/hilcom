import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/home_provider.dart';
import '../widgets/category_card.dart';
import '../widgets/product_card.dart';
import '../widgets/banner_card.dart';
import '../widgets/deal_card.dart';
import '../../../../core/theme/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: isMobile ? _buildMobileAppBar(context) : _buildWebHeader(context),
      drawer: isMobile ? const Drawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!isMobile) _buildWebSecondaryHeader(context),
            _buildHeroSection(context, isMobile),
            _buildCategorySection(context, isMobile),
            _buildBanners(context, isMobile),
            _buildProductSection(context, isMobile),
            _buildDailyBestSells(context, isMobile),
            _buildDealsOfTheDay(context, isMobile),
            _buildProductLists(context, isMobile),
            _buildBottomBanner(context, isMobile),
            _buildFeatureIcons(context, isMobile),
            _buildFooter(context, isMobile),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildMobileAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Nest', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        IconButton(icon: const Icon(Icons.shopping_cart_outlined), onPressed: () {}),
      ],
    );
  }

  PreferredSizeWidget _buildWebHeader(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            const Text('Nest', style: TextStyle(color: AppColors.primary, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(width: 40),
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text('All Categories', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    const VerticalDivider(width: 1),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for items...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                      ),
                    ),
                    const Icon(Icons.search, color: AppColors.textBody),
                    const SizedBox(width: 15),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 40),
            _buildHeaderAction(Icons.refresh, 'Compare'),
            _buildHeaderAction(Icons.favorite_border, 'Wishlist'),
            _buildHeaderAction(Icons.shopping_cart_outlined, 'Cart'),
            _buildHeaderAction(Icons.person_outline, 'Account'),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderAction(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Icon(icon, size: 24, color: AppColors.heading),
          const SizedBox(width: 5),
          Text(label, style: const TextStyle(color: AppColors.heading)),
        ],
      ),
    );
  }

  Widget _buildWebSecondaryHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.grid_view),
            label: const Text('Browse All Categories'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          const SizedBox(width: 20),
          const Text('Home', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          const SizedBox(width: 20),
          const Text('About'),
          const SizedBox(width: 20),
          const Text('Shop'),
          const SizedBox(width: 20),
          const Text('Vendors'),
          const Spacer(),
          const Icon(Icons.headset_mic_outlined, color: AppColors.textBody),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('1900 - 888', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
              Text('24/7 Support Center', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, bool isMobile) {
    return Container(
      margin: EdgeInsets.all(isMobile ? 15 : 50),
      height: isMobile ? 200 : 450,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1200&auto=format&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 20 : 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Fresh Vegetables\nBig discount',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: isMobile ? 24 : 60,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Save up to 50% off on your first order',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: isMobile ? 14 : 24,
              ),
            ),
            if (!isMobile) ...[
              const SizedBox(height: 40),
              Container(
                width: 450,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Icon(Icons.send_outlined, color: AppColors.textBody),
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Your email address',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      height: 55,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Subscribe', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50),
          child: Row(
            children: [
              Text('Featured Categories', style: Theme.of(context).textTheme.displayMedium),
              const Spacer(),
              if (!isMobile) ...[
                const Text('Cake & Milk'),
                const SizedBox(width: 15),
                const Text('Coffes & Teas'),
                const SizedBox(width: 15),
                const Text('Pet Foods'),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 180,
          child: Consumer<HomeProvider>(
            builder: (context, provider, _) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50),
                scrollDirection: Axis.horizontal,
                itemCount: provider.categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(category: provider.categories[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBanners(BuildContext context, bool isMobile) {
    if (isMobile) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            const BannerCard(
              title: 'Everyday Fresh &\nClean with Our\nProducts',
              image: 'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=400&auto=format&fit=crop',
              color: Color(0xFFF2FCE4),
            ),
            const SizedBox(width: 15),
            const BannerCard(
              title: 'Make your Breakfast\nHealthy and Easy',
              image: 'https://images.unsplash.com/photo-1494390248081-4e521a5940db?q=80&w=400&auto=format&fit=crop',
              color: Color(0xFFFFF3EB),
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
      child: Row(
        children: [
          const Expanded(
            child: BannerCard(
              title: 'Everyday Fresh &\nClean with Our\nProducts',
              image: 'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=400&auto=format&fit=crop',
              color: Color(0xFFF2FCE4),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: BannerCard(
              title: 'Make your Breakfast\nHealthy and Easy',
              image: 'https://images.unsplash.com/photo-1494390248081-4e521a5940db?q=80&w=400&auto=format&fit=crop',
              color: Color(0xFFFFF3EB),
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: BannerCard(
              title: 'The best Organic\nProducts Online',
              image: 'https://images.unsplash.com/photo-1516594798947-e65505dbb29d?q=80&w=400&auto=format&fit=crop',
              color: Color(0xFFECFFEC),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection(BuildContext context, bool isMobile) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Popular Products', style: Theme.of(context).textTheme.displayMedium),
              const Spacer(),
              if (!isMobile) ...[
                const Text('All', style: TextStyle(color: AppColors.primary)),
                const SizedBox(width: 15),
                const Text('Milks & Dairies'),
                const SizedBox(width: 15),
                const Text('Coffes & Teas'),
              ],
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
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daily Best Sells', style: Theme.of(context).textTheme.displayMedium),
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
                      image: NetworkImage('https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=300&auto=format&fit=crop'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: const Text(
                    'Bring nature\ninto your\nhome',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.heading),
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
                          return ProductCard(product: provider.dealsOfTheDay[index]);
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
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Deals Of The Day', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 30),
          SizedBox(
            height: 400,
            child: Consumer<HomeProvider>(
              builder: (context, provider, _) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
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
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 40),
      child: Consumer<HomeProvider>(
        builder: (context, provider, _) {
          if (isMobile) {
            return Column(
              children: provider.listProducts.entries.map((e) => _buildSmallProductList(e.key, e.value)).toList(),
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: provider.listProducts.entries.map((e) => Expanded(child: _buildSmallProductList(e.key, e.value))).toList(),
          );
        },
      ),
    );
  }

  Widget _buildSmallProductList(String title, List<dynamic> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.heading)),
          const SizedBox(height: 10),
          const Divider(thickness: 2, color: AppColors.primaryLight),
          const SizedBox(height: 20),
          ...products.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(p.image, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(p.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.secondary, size: 14),
                          Text(' (${p.rating})', style: const TextStyle(fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text('\$${p.price}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildBottomBanner(BuildContext context, bool isMobile) {
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
          const Text('Start You’r Daily Shopping with Nest Mart', style: TextStyle(fontSize: 18, color: AppColors.textBody)),
          const SizedBox(height: 30),
          if (!isMobile)
            Container(
              width: 400,
              height: 50,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
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

  Widget _buildFeatureIcons(BuildContext context, bool isMobile) {
    final features = [
      {'icon': Icons.sell_outlined, 'title': 'Best prices & offers', 'subtitle': 'Orders \$50 or more'},
      {'icon': Icons.local_shipping_outlined, 'title': 'Free delivery', 'subtitle': '24/7 help center'},
      {'icon': Icons.verified_user_outlined, 'title': 'Great daily deal', 'subtitle': 'When you sign up'},
      {'icon': Icons.replay_outlined, 'title': 'Wide assortment', 'subtitle': 'Mega Discounts'},
      {'icon': Icons.headset_mic_outlined, 'title': 'Easy returns', 'subtitle': 'Within 30 days'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 15 : 50, vertical: 40),
      child: isMobile
          ? Column(children: features.map((f) => _buildFeatureItem(f)).toList())
          : Row(children: features.map((f) => Expanded(child: _buildFeatureItem(f))).toList()),
    );
  }

  Widget _buildFeatureItem(Map<String, dynamic> feature) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF4F6FA), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(feature['icon'] as IconData, size: 40, color: AppColors.primary),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(feature['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(feature['subtitle'] as String, style: const TextStyle(color: AppColors.textBody, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 50),
      color: Colors.white,
      child: Column(
        children: [
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Nest', style: TextStyle(color: AppColors.primary, fontSize: 32, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      const Text('Awesome grocery store website\ntemplate'),
                      const SizedBox(height: 20),
                      _buildFooterContactItem(Icons.location_on_outlined, 'Address: 5171 W Campbell Ave undefined Kent, Utah 53127 United States'),
                      _buildFooterContactItem(Icons.headset_mic_outlined, 'Call Us: (+91) - 540-025-124553'),
                      _buildFooterContactItem(Icons.email_outlined, 'Email: sale@Nest.com'),
                      _buildFooterContactItem(Icons.access_time, 'Hours: 10:00 - 18:00, Mon - Sat'),
                    ],
                  ),
                ),
                _buildFooterColumn('Company', ['About Us', 'Delivery Information', 'Privacy Policy', 'Terms & Conditions', 'Contact Us', 'Support Center']),
                _buildFooterColumn('Account', ['Sign In', 'View Cart', 'My Wishlist', 'Track My Order', 'Help Ticket', 'Shipping Details']),
                _buildFooterColumn('Corporate', ['Become a Vendor', 'Affiliate Program', 'Farm Business', 'Farm Careers', 'Our Suppliers', 'Accessibility']),
                _buildFooterColumn('Popular', ['Milk & Flavoured Milk', 'Butter and Margarine', 'Eggs Substitutes', 'Marmalades', 'Sour Cream and Dips', 'Tea & Kombucha']),
              ],
            ),
          const Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('© 2024, Nest - Flutter Ecommerce Replica\nAll rights reserved'),
              if (!isMobile)
                Row(
                  children: [
                    const Icon(Icons.phone_in_talk, color: AppColors.primary),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1900 - 6666', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('Working 8:00 - 22:00', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(width: 40),
                    const Icon(Icons.phone_in_talk, color: AppColors.primary),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1900 - 8888', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('24/7 Support Center', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFooterContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildFooterColumn(String title, List<String> links) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 20),
          ...links.map((link) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(link, style: const TextStyle(color: AppColors.textBody)),
          )),
        ],
      ),
    );
  }
}
