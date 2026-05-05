import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../../domain/models/cart_item_model.dart';
import '../providers/home_provider.dart';
import '../widgets/layout/web_header.dart';
import '../widgets/layout/web_secondary_header.dart';
import '../widgets/layout/mobile_app_bar.dart';
import '../widgets/layout/mobile_drawer.dart';
import '../widgets/layout/footer.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: isMobile ? const MobileAppBar() : const WebHeader(),
      drawer: isMobile ? const MobileDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!isMobile) const WebSecondaryHeader(currentPage: 'Shop'),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 15 : 50,
                vertical: 30,
              ),
              child: Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  if (provider.cartItems.isEmpty) {
                    return _buildEmptyCart(context, isMobile);
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Cart',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: isMobile ? 32 : 48,
                              fontWeight: FontWeight.bold,
                              color: AppColors.heading,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'There are ${provider.cartCount} products in your cart',
                        style: const TextStyle(color: AppColors.textBody, fontSize: 16),
                      ),
                      const SizedBox(height: 40),
                      if (isMobile)
                        _buildMobileCart(context, provider)
                      else
                        _buildWebCart(context, provider),
                    ],
                  );
                },
              ),
            ),
            Footer(isMobile: isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context, bool isMobile) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: AppColors.primary.withValues(alpha: 0.2)),
          const SizedBox(height: 20),
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.heading),
          ),
          const SizedBox(height: 10),
          const Text(
            'Looks like you haven\'t added anything to your cart yet.',
            style: TextStyle(color: AppColors.textBody),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => context.go('/'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Back to Shop', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildWebCart(BuildContext context, HomeProvider provider) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              _buildCartTable(context, provider),
              const SizedBox(height: 30),
              Row(
                children: [
                  OutlinedButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Continue Shopping'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      side: const BorderSide(color: AppColors.primary),
                      foregroundColor: AppColors.primary,
                    ),
                  ),
                  const Spacer(),
                  OutlinedButton.icon(
                    onPressed: () => provider.clearCart(),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Clear Cart'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      side: const BorderSide(color: Colors.red),
                      foregroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 50),
        Expanded(
          flex: 1,
          child: _buildOrderSummary(context, provider),
        ),
      ],
    );
  }

  Widget _buildMobileCart(BuildContext context, HomeProvider provider) {
    return Column(
      children: [
        ...provider.cartItems.map((item) => _buildCartItemCard(context, provider, item)),
        const SizedBox(height: 30),
        _buildOrderSummary(context, provider),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () => provider.clearCart(),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            foregroundColor: Colors.red,
            side: const BorderSide(color: Colors.red),
          ),
          child: const Text('Clear Cart'),
        ),
      ],
    );
  }

  Widget _buildCartTable(BuildContext context, HomeProvider provider) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1.5),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(0.5),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            children: [
              _buildTableHeader('Product'),
              _buildTableHeader('Unit Price'),
              _buildTableHeader('Quantity'),
              _buildTableHeader('Subtotal'),
              _buildTableHeader(''),
            ],
          ),
          ...provider.cartItems.map((item) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: InkWell(
                      onTap: () => context.push('/product', extra: item.product),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(item.product.image, width: 80, height: 80, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text(item.product.category, style: const TextStyle(color: AppColors.textBody, fontSize: 12)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildTableCell('GH₵ ${item.product.price.toStringAsFixed(2)}'),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: _buildQuantitySelector(provider, item),
                  ),
                  _buildTableCell('GH₵ ${item.total.toStringAsFixed(2)}', isBold: true),
                  IconButton(
                    onPressed: () => provider.removeFromCart(item),
                    icon: const Icon(Icons.delete_outline, color: AppColors.textBody),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildCartItemCard(BuildContext context, HomeProvider provider, CartItemModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => context.push('/product', extra: item.product),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(item.product.image, width: 80, height: 80, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: InkWell(
                  onTap: () => context.push('/product', extra: item.product),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.product.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(item.product.category, style: const TextStyle(color: AppColors.textBody, fontSize: 12)),
                      const SizedBox(height: 10),
                      Text('GH₵ ${item.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () => provider.removeFromCart(item),
                icon: const Icon(Icons.close, size: 20),
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuantitySelector(provider, item),
              Text('Total: GH₵ ${item.total.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.heading)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(HomeProvider provider, CartItemModel item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => provider.updateQuantity(item, item.quantity - 1),
            child: const Icon(Icons.remove, size: 16, color: AppColors.primary),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          InkWell(
            onTap: () => provider.updateQuantity(item, item.quantity + 1),
            child: const Icon(Icons.add, size: 16, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context, HomeProvider provider) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Order Summary', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.heading)),
          const SizedBox(height: 30),
          _buildSummaryRow('Subtotal', 'GH₵ ${provider.cartTotal.toStringAsFixed(2)}'),
          const Divider(height: 30),
          _buildSummaryRow('Shipping', 'Free'),
          const Divider(height: 30),
          _buildSummaryRow('Estimate for', 'Ghana'),
          const Divider(height: 30),
          _buildSummaryRow('Total', 'GH₵ ${provider.cartTotal.toStringAsFixed(2)}', isBold: true),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Order Placed'),
                  content: const Text('Thank you for your order! We will process it shortly.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        provider.clearCart();
                        context.go('/');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Proceed To CheckOut', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(width: 10),
                Icon(Icons.shopping_bag_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: isBold ? AppColors.heading : AppColors.textBody, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: isBold ? 18 : 16)),
        Text(value, style: TextStyle(color: isBold ? AppColors.primary : AppColors.heading, fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: isBold ? 24 : 16)),
      ],
    );
  }

  Widget _buildTableHeader(String label) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.heading)),
    );
  }

  Widget _buildTableCell(String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: isBold ? 18 : 16, color: isBold ? AppColors.primary : AppColors.heading)),
    );
  }
}
