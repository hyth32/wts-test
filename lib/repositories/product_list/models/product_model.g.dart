// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: (json['productId'] as num).toInt(),
      title: json['title'] as String,
      productDescription: json['productDescription'] as String,
      price: (json['price'] as num).toInt(),
      rating: (json['rating'] as num?)?.toDouble(),
      isAvailableForSale: const BoolJsonConverter()
          .fromJson((json['isAvailableForSale'] as num?)?.toInt()),
      imageUrl: json['imageUrl'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'productDescription': instance.productDescription,
      'price': instance.price,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
      'images': instance.images,
      'isAvailableForSale':
          const BoolJsonConverter().toJson(instance.isAvailableForSale),
    };
