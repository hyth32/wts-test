import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.productId,
    required this.title,
    required this.productDescription,
    required this.price,
    required this.rating,
    this.imageUrl,
    this.images,
    required this.isAvailableForSale,
  });

  final int productId;
  final String title;
  final String productDescription;
  final int price;
  final double? rating;
  final String? imageUrl;
  final List<String>? images;
  final bool isAvailableForSale;

  factory Product.fromJSON(Map<String, dynamic> json) {
    return Product(
      productId: json['productId'],
      title: json['title'],
      productDescription: json['productDescription'] ?? '',
      price: json['price'],
      rating: json['rating']?.toDouble(),
      imageUrl: json['imageUrl'],
      images: List<String>.from(json['images']),
      isAvailableForSale: json['isAvailableForSale'] == 1,
    );
  }

  @override
  List<Object?> get props => [
        productId,
        title,
        productDescription,
        price,
        rating,
        imageUrl,
        images,
        isAvailableForSale
      ];
}
