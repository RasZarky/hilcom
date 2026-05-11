import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../providers/home_provider.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/web_secondary_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/mobile_drawer.dart';
import '../widgets/layout/footer.dart';
import '../widgets/product_card.dart';
import '../../domain/models/product_model.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String? _selectedCategory;
  RangeValues _priceRange = const RangeValues(0, 100000);
  String _sortBy = 'Newest';

  List<ProductModel> _getFilteredProducts(HomeProvider provider) {
    var products = provider.allProducts.where((p) {
      final searchQuery = provider.searchQuery.toLowerCase();
      bool searchMatch = searchQuery.isEmpty || 
          p.title.toLowerCase().contains(searchQuery) ||
          p.category.toLowerCase().contains(searchQuery);
          
      bool categoryMatch = _selectedCategory == null || p.category == _selectedCategory;
      bool priceMatch = p.price >= _priceRange.start && p.price <= _priceRange.end;
      return searchMatch && categoryMatch && priceMatch;
    }).toList();

    if (_sortBy == 'Price: Low to High') {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'Price: High to Low') {
      products.sort((a, b) => b.price.compareTo(a.price));
    }
    
    return products;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;
    final provider = context.watch<HomeProvider>();
    final products = _getFilteredProducts(provider);

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!isMobile) const WebSecondaryHeader(currentPage: 'All Products'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 15 : 50,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(context, products.length, isMobile),
                  const SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMobile)
                        SizedBox(
                          width: 300,
                          child: _buildFilters(context, provider),
                        ),
                      if (!isMobile) const SizedBox(width: 40),
                      Expanded(
                        child: Column(
                          children: [
                            if (isMobile) ...[
                              _buildMobileToolbar(context, provider),
                              const SizedBox(height: 24),
                            ],
                            if (products.isEmpty)
                              _buildEmptyState(provider)
                            else
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: isMobile ? 2 : 4,
                                  childAspectRatio: 0.62,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return ProductCard(product: products[index]);
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context, int count, bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'All Products',
              style: TextStyle(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.w900,
                color: AppColors.heading,
                letterSpacing: -1,
              ),
            ),
            if (!isMobile)
              _buildSortDropdown(),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'We found $count products for you!',
          style: const TextStyle(color: AppColors.textBody, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _sortBy,
          icon: const Icon(Icons.expand_more, size: 20, color: AppColors.primary),
          style: const TextStyle(color: AppColors.heading, fontWeight: FontWeight.bold, fontSize: 14),
          items: ['Newest', 'Price: Low to High', 'Price: High to Low']
              .map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
          onChanged: (val) {
            if (val != null) setState(() => _sortBy = val);
          },
        ),
      ),
    );
  }

  Widget _buildMobileToolbar(BuildContext context, HomeProvider provider) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => _showMobileFilters(context, provider),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.tune_rounded, size: 20, color: AppColors.primary),
                  SizedBox(width: 10),
                  Text('Filters', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.heading)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortBy,
                isExpanded: true,
                icon: const Icon(Icons.expand_more, size: 20, color: AppColors.textBody),
                items: ['Newest', 'Price: Low to High', 'Price: High to Low']
                    .map((val) => DropdownMenuItem(
                      value: val, 
                      child: Text(val, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))
                    )).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _sortBy = val);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context, HomeProvider provider, {StateSetter? setModalState}) {
    void update(VoidCallback fn) {
      if (setModalState != null) {
        setModalState(fn);
      }
      setState(fn);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterHeader('Category'),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildCategoryListItem('All Products', _selectedCategory == null, () => update(() => _selectedCategory = null)),
              ...provider.categories.map((c) => _buildCategoryListItem(
                c.title, 
                _selectedCategory == c.title, 
                () => update(() => _selectedCategory = c.title)
              )),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildFilterHeader('Price Range'),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              RangeSlider(
                values: _priceRange,
                min: 0,
                max: 100000,
                divisions: 100,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primaryLight,
                onChanged: (values) => update(() => _priceRange = values),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPriceTag('Min', _priceRange.start),
                  _buildPriceTag('Max', _priceRange.end),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton.icon(
            onPressed: () {
              update(() {
                _selectedCategory = null;
                _priceRange = const RangeValues(0, 100000);
                _sortBy = 'Newest';
              });
              provider.setSearchQuery('');
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Reset All Filters', style: TextStyle(fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary.withOpacity(0.1),
              foregroundColor: AppColors.primary,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 18, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.heading)),
      ],
    );
  }

  Widget _buildCategoryListItem(String title, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.05) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              size: 20,
              color: isSelected ? AppColors.primary : AppColors.textBody.withOpacity(0.4),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.primary : AppColors.heading,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceTag(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textBody, fontWeight: FontWeight.bold)),
        Text('GH₵ ${value.round()}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: AppColors.heading)),
      ],
    );
  }

  void _showMobileFilters(BuildContext context, HomeProvider provider) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          final count = _getFilteredProducts(provider).length;
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: const BoxDecoration(
              color: Color(0xFFFBFBFB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Filter Products', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.heading)),
                      IconButton(
                        onPressed: () => Navigator.pop(context), 
                        icon: const Icon(Icons.close_rounded, size: 28),
                        style: IconButton.styleFrom(backgroundColor: Colors.white, elevation: 1),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    physics: const BouncingScrollPhysics(),
                    child: _buildFilters(context, provider, setModalState: setModalState),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4))],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: Text('Show $count Results', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _buildEmptyState(HomeProvider provider) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 80),
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
            child: const Icon(Icons.search_off_rounded, size: 80, color: AppColors.border),
          ),
          const SizedBox(height: 24),
          const Text('No results found', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.heading)),
          const SizedBox(height: 8),
          const Text('Try adjusting your filters or search terms', style: TextStyle(color: AppColors.textBody, fontSize: 16)),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedCategory = null;
                _priceRange = const RangeValues(0, 100000);
              });
              provider.setSearchQuery('');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Clear All Filters', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
