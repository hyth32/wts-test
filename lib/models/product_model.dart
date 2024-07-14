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

    @override
    List<Object?> get props => [
          productId,
          rating,
    ];
  }
