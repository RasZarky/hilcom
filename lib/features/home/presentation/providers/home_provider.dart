import 'package:flutter/material.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/product_model.dart';
import '../../domain/models/cart_item_model.dart';

class HomeProvider extends ChangeNotifier {
  final List<CartItemModel> _cartItems = [];
  final List<ProductModel> _wishlistItems = [];
  String _searchQuery = '';

  List<CartItemModel> get cartItems => _cartItems;
  List<ProductModel> get wishlistItems => _wishlistItems;
  String get searchQuery => _searchQuery;

  double get cartTotal => _cartItems.fold(0, (sum, item) => sum + item.total);

  int get cartCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  int get wishlistCount => _wishlistItems.length;

  void addToCart(ProductModel product, {int quantity = 1}) {
    final existingIndex = _cartItems.indexWhere((item) => item.product.title == product.title);
    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += quantity;
    } else {
      _cartItems.add(CartItemModel(product: product, quantity: quantity));
    }
    notifyListeners();
  }

  void addAllToCart(List<ProductModel> products) {
    for (var product in products) {
      final existingIndex = _cartItems.indexWhere((item) => item.product.title == product.title);
      if (existingIndex >= 0) {
        _cartItems[existingIndex].quantity += 1;
      } else {
        _cartItems.add(CartItemModel(product: product, quantity: 1));
      }
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

  void toggleWishlist(ProductModel product) {
    final index = _wishlistItems.indexWhere((item) => item.title == product.title);
    if (index >= 0) {
      _wishlistItems.removeAt(index);
    } else {
      _wishlistItems.add(product);
    }
    notifyListeners();
  }

  bool isInWishlist(ProductModel product) {
    return _wishlistItems.any((item) => item.title == product.title);
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<ProductModel> get allProducts {
    final products = [...popularProducts, ...dealsOfTheDay];
    return { for (var p in products) p.title : p }.values.toList();
  }

  List<ProductModel> get filteredProducts {
    final products = allProducts;
    
    if (_searchQuery.isEmpty) return products;
    
    return products.where((product) {
      return product.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             product.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             product.brand.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
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
      videoUrl: 'https://www.tiktok.com/@hilcomltd/video/7571909547321756940?q=hilcom&t=1778036418950',
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
      videoUrl: 'https://www.tiktok.com/@hilcomltd/video/7630112951592160532?q=hilcom%20tv&t=1778036600053',
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
      title: 'iPhone 15 Pro Max 256GB - Titanium',
      category: 'Electronics',
      image: 'https://images.unsplash.com/photo-1696446701796-da61225697cc?auto=format&fit=crop&q=80&w=400',
      rating: 4.9,
      brand: 'Apple',
      price: 1199.00,
      oldPrice: 1299.00,
      badge: 'Hot',
      videoUrl: 'https://www.tiktok.com/@hilcomltd/video/7617196949942439175?q=hilcom%20iphone&t=1778036768732',
    ),
    ProductModel(
      title: 'Dyson V15 Detect Cordless Vacuum',
      category: 'Appliances',
      image: 'https://images.unsplash.com/photo-1558317374-067df5f15430?auto=format&fit=crop&q=80&w=400',
      rating: 4.8,
      brand: 'Dyson',
      price: 749.99,
      oldPrice: 799.99,
      videoUrl: 'https://www.tiktok.com/@dyson/video/7199223344556677889',
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
      videoUrl: 'https://www.tiktok.com/@luxuryfurniture/video/7234567890123456789',
    ),
    ProductModel(
      title: 'KitchenAid Artisan Series 5-Quart Mixer',
      category: 'Appliances',
      image: 'https://images.unsplash.com/photo-1594385208974-2e75f9d8ad48?auto=format&fit=crop&q=80&w=400',
      rating: 4.9,
      brand: 'KitchenAid',
      price: 449.99,
      oldPrice: 499.99,
      badge: 'Deal',
      videoUrl: 'https://www.tiktok.com/@kitchenaidusa/video/7211223344556677889',
    ),
    ProductModel(
      title: 'Yamaha YZF-R1 Superbike 2023',
      category: 'Motors',
      image: 'https://images.unsplash.com/photo-1444491741275-3747c53c99b4?auto=format&fit=crop&q=80&w=800',
      rating: 5.0,
      brand: 'Yamaha',
      price: 17599.00,
      oldPrice: 18200.00,
      videoUrl: 'https://www.tiktok.com/@yamahamotoreu/video/7212345678901234567',
    ),
  ];

  Map<String, List<ProductModel>> get listProducts => {
    'Top Selling': popularProducts.take(3).toList(),
    'Trending Items': popularProducts.take(3).toList(),
    'Recently Added': popularProducts.take(3).toList(),
    'Top Rated': popularProducts.take(3).toList(),
  };
}
