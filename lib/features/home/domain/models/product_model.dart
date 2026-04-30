class ProductModel {
  final String title;
  final String category;
  final String image;
  final double rating;
  final String brand;
  final double price;
  final double? oldPrice;
  final String? badge;

  ProductModel({
    required this.title,
    required this.category,
    required this.image,
    required this.rating,
    required this.brand,
    required this.price,
    this.oldPrice,
    this.badge,
  });
}
