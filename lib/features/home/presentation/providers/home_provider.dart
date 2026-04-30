import 'package:flutter/material.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  List<CategoryModel> get categories => [
    CategoryModel(title: 'Milks & Dairies', image: 'https://cdn-icons-png.flaticon.com/512/869/869476.png', itemCount: 26, color: 'F2FCE4'),
    CategoryModel(title: 'Wines & Drinks', image: 'https://cdn-icons-png.flaticon.com/512/3122/3122002.png', itemCount: 28, color: 'FFF3EB'),
    CategoryModel(title: 'Clothing & beauty', image: 'https://cdn-icons-png.flaticon.com/512/3050/3050230.png', itemCount: 14, color: 'ECFFEC'),
    CategoryModel(title: 'Fresh Seafood', image: 'https://cdn-icons-png.flaticon.com/512/2346/2346610.png', itemCount: 54, color: 'FEEFEA'),
    CategoryModel(title: 'Pet Foods', image: 'https://cdn-icons-png.flaticon.com/512/628/628283.png', itemCount: 56, color: 'FFF3E0'),
    CategoryModel(title: 'Fast food', image: 'https://cdn-icons-png.flaticon.com/512/737/737596.png', itemCount: 72, color: 'F2FCE4'),
    CategoryModel(title: 'Vegetables', image: 'https://cdn-icons-png.flaticon.com/512/2329/2329903.png', itemCount: 36, color: 'FEEFEA'),
    CategoryModel(title: 'Fruits', image: 'https://cdn-icons-png.flaticon.com/512/1625/1625048.png', itemCount: 123, color: 'FFF3EB'),
    CategoryModel(title: 'Snack', image: 'https://cdn-icons-png.flaticon.com/512/2553/2553691.png', itemCount: 34, color: 'FFF3E0'),
    CategoryModel(title: 'Baking material', image: 'https://cdn-icons-png.flaticon.com/512/2713/2713563.png', itemCount: 65, color: 'F2FCE4'),
  ];

  List<ProductModel> get popularProducts => [
    ProductModel(
      title: 'Seeds of Change Organic Quinoa, Brown, & Red Rice',
      category: 'Snack',
      image: 'https://picsum.photos/id/102/400/400',
      rating: 4.0,
      brand: 'NestFood',
      price: 28.85,
      oldPrice: 32.8,
      badge: 'Hot',
    ),
    ProductModel(
      title: 'All Natural Italian-Style Chicken Meatballs',
      category: 'Hodo Foods',
      image: 'https://picsum.photos/id/225/400/400',
      rating: 3.5,
      brand: 'Stouffer',
      price: 52.85,
      oldPrice: 55.8,
      badge: 'Sale',
    ),
    ProductModel(
      title: 'Angie’s Boomchickapop Sweet & Salty Kettle Corn',
      category: 'Snack',
      image: 'https://picsum.photos/id/292/400/400',
      rating: 4.0,
      brand: 'Starbucks',
      price: 48.85,
      oldPrice: 52.8,
      badge: 'New',
    ),
    ProductModel(
      title: 'Foster Farms Takeout Crispy Classic Buffalo Wings',
      category: 'Vegetables',
      image: 'https://picsum.photos/id/106/400/400',
      rating: 4.0,
      brand: 'NestFood',
      price: 17.85,
      oldPrice: 19.8,
    ),
    ProductModel(
      title: 'Blue Diamond Almonds Lightly Salted Vegetables',
      category: 'Pet Foods',
      image: 'https://picsum.photos/id/111/400/400',
      rating: 4.0,
      brand: 'NestFood',
      price: 23.85,
      oldPrice: 25.8,
      badge: '-14%',
    ),
  ];

  List<ProductModel> get dealsOfTheDay => [
    ProductModel(
      title: 'Fresh Organic Carrots',
      category: 'Vegetables',
      image: 'https://picsum.photos/id/1040/400/400',
      rating: 4.5,
      brand: 'NestFood',
      price: 32.85,
      oldPrice: 33.8,
    ),
    ProductModel(
      title: 'Red Delicious Apples',
      category: 'Fruits',
      image: 'https://picsum.photos/id/1080/400/400',
      rating: 4.8,
      brand: 'FruitCo',
      price: 12.85,
      oldPrice: 15.8,
    ),
    ProductModel(
      title: 'Whole Grain Bread',
      category: 'Bakery',
      image: 'https://picsum.photos/id/139/400/400',
      rating: 4.0,
      brand: 'BakeHouse',
      price: 4.85,
      oldPrice: 5.8,
    ),
    ProductModel(
      title: 'Organic Milk 1L',
      category: 'Dairy',
      image: 'https://picsum.photos/id/102/400/400',
      rating: 4.9,
      brand: 'DairyFarm',
      price: 3.85,
      oldPrice: 4.8,
    ),
  ];

  Map<String, List<ProductModel>> get listProducts => {
    'Top Selling': popularProducts.take(3).toList(),
    'Trending Products': popularProducts.take(3).toList(),
    'Recently added': popularProducts.take(3).toList(),
    'Top Rated': popularProducts.take(3).toList(),
  };
}
