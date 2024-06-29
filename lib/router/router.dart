import 'package:wts_test/features/categories/view/categories_screen.dart';
import '../features/product/view/view.dart';
import '../features/products_list/view/view.dart';

final routes = {
  '/': (context) => const CategoriesScreen(),
  '/list': (context) => const ProductsScreen(),
  '/product': (context) => const ProductScreen(),
};