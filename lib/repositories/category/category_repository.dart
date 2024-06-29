import 'package:dio/dio.dart';
import 'package:wts_test/api/api.dart';
import 'category.dart';

class CategoryRepository implements AbstractCategoryRepository {
  CategoryRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<Category>> getCategoriesList() async {
    final response = await BaseApi(dio: dio).get('common/category/list') as Map<String, dynamic>;
    final rawCategories = response['categories'] as List<dynamic>;
    List<Category> categories = rawCategories.map((category) => Category.fromJSON(category)).toList();
    return categories;
  }
}