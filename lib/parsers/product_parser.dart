import 'package:wts_test/models/product_model.dart';
import 'package:wts_test/parsers/model_factory.dart';

class ProductParser implements JsonParser<Product> {
  @override
  Product fromJson(Map<String, dynamic> json) {
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
}