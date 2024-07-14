import 'package:wts_test/repositories/category/models/category_model.dart';
import 'model_factory.dart';

class CategoryParser implements JsonParser<Category> {
  @override
  Category fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      hasSubcategories: json['hasSubcategories'],
      fullName: json['fullName'],
      categoryDescription: json['categoryDescription'] ?? '',
    );
  }
}