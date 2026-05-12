import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:hilcom/core/theme/app_colors.dart';
import '../../domain/models/product_model.dart';
import '../providers/home_provider.dart';
import '../providers/auth_provider.dart';

class DealCard extends StatelessWidget {
  final ProductModel product;

  const DealCard({super.key, required this.product});

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
                  width: 320,
                  height: 400,
                  color: AppColors.border.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 320,
                  height: 400,
                  color: AppColors.border.withOpacity(0.1),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image_not_supported_outlined, size: 50, color: AppColors.textBody),
                      SizedBox(height: 10),
                      Text('Image not available', style: TextStyle(color: AppColors.textBody)),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (product.dealEndTime != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _DealCountdown(endTime: product.dealEndTime!),
                  ),
                Container(
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 15,
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
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.heading),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('GH₵ ${product.price.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                                  if (product.oldPrice != null) ...[
                                    const SizedBox(width: 5),
                                    Text('GH₵ ${product.oldPrice?.toStringAsFixed(2)}', style: const TextStyle(decoration: TextDecoration.lineThrough, color: AppColors.textBody, fontSize: 14)),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Material(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                            child: InkWell(
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
                              borderRadius: BorderRadius.circular(8),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.shopping_cart_outlined, size: 16, color: AppColors.primary),
                                    SizedBox(width: 6),
                                    Text(
                                      'Add', 
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 13, 
                                        fontWeight: FontWeight.w800
                                      )
                                    ),
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}

class _DealCountdown extends StatefulWidget {
  final DateTime endTime;
  const _DealCountdown({required this.endTime});

  @override
  State<_DealCountdown> createState() => _DealCountdownState();
}

class _DealCountdownState extends State<_DealCountdown> {
  Timer? _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.endTime.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _timeLeft = widget.endTime.difference(DateTime.now());
          if (_timeLeft.isNegative) {
            _timer?.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_timeLeft.isNegative) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'DEAL EXPIRED',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeBox(_timeLeft.inDays.toString().padLeft(2, '0'), 'Days'),
        _buildTimeBox((_timeLeft.inHours % 24).toString().padLeft(2, '0'), 'Hours'),
        _buildTimeBox((_timeLeft.inMinutes % 60).toString().padLeft(2, '0'), 'Mins'),
        _buildTimeBox((_timeLeft.inSeconds % 60).toString().padLeft(2, '0'), 'Secs'),
      ],
    );
  }

  Widget _buildTimeBox(String value, String label) {
    return Container(
      width: 55,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value, 
            style: const TextStyle(
              color: AppColors.primary, 
              fontWeight: FontWeight.w900, 
              fontSize: 16
            )
          ),
          Text(
            label, 
            style: const TextStyle(
              fontSize: 9, 
              color: AppColors.textBody, 
              fontWeight: FontWeight.bold
            )
          ),
        ],
      ),
    );
  }
}
