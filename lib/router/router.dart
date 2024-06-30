import 'package:wts_test/features/categories/categories.dart';
import 'package:wts_test/features/product_details/product_details.dart';
import 'package:wts_test/features/products_list/products_list.dart';

final routes = {
  '/': (context) => const CategoriesScreen(),
  '/list': (context) => const ProductListScreen(),
  '/product': (context) => const ProductDetailsScreen(),
};