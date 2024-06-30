import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/api/api.dart';
import 'package:wts_test/repositories/category/category.dart';
import 'package:wts_test/repositories/product_details/product_details.dart';

import 'repositories/product_list/product_list.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<BaseApi>(() => BaseApi(dio: locator<Dio>()));
  locator.registerLazySingleton<AbstractCategoryRepository>(() => CategoryRepository(dio: locator<Dio>()));
  locator.registerLazySingleton<AbstractProductListRepository>(() => ProductListRepository(dio: locator<Dio>()));
  locator.registerLazySingleton<AbstractProductDetailsRepository>(() => ProductDetailsRepository(dio: locator<Dio>()));
}