import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
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

  //TODO: Добавить кастомный BoolJsonConverter
  final int isAvailableForSale;

  bool get isAvailable => isAvailableForSale == 1;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object?> get props => [
        productId,
        rating,
      ];
}
