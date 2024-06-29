import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wts_test/api/api.dart';
import 'package:wts_test/repositories/category/category_repository.dart';
import 'package:wts_test/repositories/product/product_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<BaseApi>(() => BaseApi(dio: locator<Dio>()));
  locator.registerLazySingleton<CategoryRepository>(() => CategoryRepository(dio: locator<Dio>()));
  locator.registerLazySingleton<ProductRepository>(() => ProductRepository(dio: locator<Dio>()));
}