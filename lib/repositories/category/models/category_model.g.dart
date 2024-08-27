// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      categoryId: (json['categoryId'] as num).toInt(),
      title: json['title'] as String,
      hasSubcategories: (json['hasSubcategories'] as num).toInt(),
      fullName: json['fullName'] as String,
      categoryDescription: json['categoryDescription'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'hasSubcategories': instance.hasSubcategories,
      'fullName': instance.fullName,
      'categoryDescription': instance.categoryDescription,
    };
