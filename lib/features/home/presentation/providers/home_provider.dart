import 'package:flutter/material.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/product_model.dart';
import '../../domain/models/cart_item_model.dart';

class HomeProvider extends ChangeNotifier {
  final List<CartItemModel> _cartItems = [];

  List<CartItemModel> get cartItems => _cartItems;

  double get cartTotal => _cartItems.fold(0, (sum, item) => sum + item.total);

  int get cartCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);

  void addToCart(ProductModel product, {int quantity = 1}) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.title == product.title);
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItemModel(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void removeFromCart(CartItemModel item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void updateQuantity(CartItemModel item, int quantity) {
    if (quantity <= 0) {
      removeFromCart(item);
    } else {
      item.quantity = quantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  List<CategoryModel> get categories => [
    CategoryModel(title: 'Motors & Cars', image: 'https://cdn-icons-png.flaticon.com/512/3202/3202926.png', itemCount: 156, color: 'F2FCE4'),
    CategoryModel(title: 'Smart TVs', image: 'https://cdn-icons-png.flaticon.com/512/716/716429.png', itemCount: 428, color: 'FFF3EB'),
    CategoryModel(title: 'Home Furniture', image: 'https://cdn-icons-png.flaticon.com/512/2590/2590525.png', itemCount: 214, color: 'ECFFEC'),
    CategoryModel(title: 'Audio Systems', image: 'https://cdn-icons-png.flaticon.com/512/2983/2983058.png', itemCount: 84, color: 'FEEFEA'),
    CategoryModel(title: 'Appliances', image: 'https://cdn-icons-png.flaticon.com/512/2916/2916115.png', itemCount: 123, color: 'FFF3E0'),
    CategoryModel(title: 'Bed & Bath', image: 'https://cdn-icons-png.flaticon.com/512/3063/3063822.png', itemCount: 65, color: 'F2FCE4'),
    CategoryModel(title: 'Fashion', image: 'https://cdn-icons-png.flaticon.com/512/3050/3050230.png', itemCount: 542, color: 'FEEFEA'),
    CategoryModel(title: 'Groceries', image: 'https://cdn-icons-png.flaticon.com/512/3724/3724720.png', itemCount: 1230, color: 'FFF3EB'),
  ];

  List<ProductModel> get popularProducts => [
    ProductModel(
      title: 'Tesla Model S Plaid 2024 - Midnight Silver',
      category: 'Motors',
      image: 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?auto=format&fit=crop&q=80&w=400',
      rating: 4.9,
      brand: 'Tesla',
      price: 89990.00,
      oldPrice: 94990.0,
      badge: 'Hot',
    ),
    ProductModel(
      title: 'Samsung 75" Class QN90C Neo QLED 4K Smart TV',
      category: 'Televisions',
      image: 'https://images.unsplash.com/photo-1593305841991-05c297ba4575?auto=format&fit=crop&q=80&w=400',
      rating: 4.8,
      brand: 'Samsung',
      price: 2299.99,
      oldPrice: 2799.99,
      badge: 'Sale',
    ),
    ProductModel(
      title: 'Sony WH-1000XM5 Wireless Noise Canceling Headphones',
      category: 'Electronics',
      image: 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?auto=format&fit=crop&q=80&w=400',
      rating: 4.7,
      brand: 'Sony',
      price: 398.00,
      oldPrice: 420.00,
      badge: 'New',
    ),
    ProductModel(
      title: 'Memory Foam Queen Mattress with Cooling Gel',
      category: 'Bed & Bath',
      image: 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&q=80&w=400',
      rating: 4.5,
      brand: 'SleepWell',
      price: 599.00,
      oldPrice: 750.00,
    ),
    ProductModel(
      title: 'Harman Kardon SoundStick 4 - Bluetooth System',
      category: 'Audio Systems',
      image: 'https://images.unsplash.com/photo-1545454675-3531b543be5d?auto=format&fit=crop&q=80&w=400',
      rating: 4.6,
      brand: 'Harman Kardon',
      price: 299.95,
      oldPrice: 349.00,
      badge: '-15%',
    ),
  ];

  List<ProductModel> get dealsOfTheDay => [
    ProductModel(
      title: 'Classic Leather King Bed Frame',
      category: 'Furniture',
      image: 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&q=80&w=400',
      rating: 4.8,
      brand: 'LuxLiving',
      price: 1299.00,
      oldPrice: 1599.00,
    ),
    ProductModel(
      title: 'Bose Surround Sound System 700',
      category: 'Audio Systems',
      image: 'https://images.unsplash.com/photo-1631049307264-da0ec9d70304?auto=format&fit=crop&q=80&w=400',
      rating: 4.9,
      brand: 'Bose',
      price: 799.00,
      oldPrice: 899.00,
    ),
    ProductModel(
      title: 'Yamaha YZF-R1 Superbike 2023',
      category: 'Motors',
      image: 'https://images.unsplash.com/photo-1444491741275-3747c53c99b4?auto=format&fit=crop&q=80&w=800',
      rating: 5.0,
      brand: 'Yamaha',
      price: 17599.00,
      oldPrice: 18200.00,
    ),
  ];

  Map<String, List<ProductModel>> get listProducts => {
    'Top Selling': popularProducts.take(3).toList(),
    'Trending Items': popularProducts.take(3).toList(),
    'Recently Added': popularProducts.take(3).toList(),
    'Top Rated': popularProducts.take(3).toList(),
  };
}
