import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'api/base_api.dart';
import 'repositories/category/abstract_category_repository.dart';
import 'repositories/category/category_repository.dart';
import 'repositories/product_details/abstract_product_details_repository.dart';
import 'repositories/product_details/product_details_repository.dart';
import 'repositories/product_list/abstract_product_list_repository.dart';
import 'repositories/product_list/product_list_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<BaseApi>(() => BaseApi(dio: locator<Dio>()));
  locator.registerLazySingleton<AbstractCategoryRepository>(() => CategoryRepository());
  locator.registerLazySingleton<AbstractProductListRepository>(() => ProductListRepository());
  locator.registerLazySingleton<AbstractProductDetailsRepository>(() => ProductDetailsRepository());
}