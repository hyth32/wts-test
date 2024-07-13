import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/api/base_api.dart';
import 'package:wts_test/repositories/category/models/category_model.dart';

import 'abstract_category_repository.dart';

class CategoryRepository implements AbstractCategoryRepository {
  @override
  Future<List<Category>> getCategoriesList() async {
    try {
      final response = await GetIt.instance<BaseApi>().get('common/category/list') as Map<String, dynamic>;
      final rawCategories = response['categories'] as List<dynamic>;
      List<Category> categories = rawCategories.map((category) => Category.fromJSON(category)).toList();
      categories.insert(0, allProductsCategory);
      return categories;
    } catch (e) {
      debugPrint('Exception: $e');
      return <Category>[];
    }
  }
}