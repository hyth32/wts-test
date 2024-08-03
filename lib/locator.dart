import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:wts_test/api/base_api/base_api.dart';
import 'package:wts_test/repositories/category/abstract_category_repository.dart';
import 'package:wts_test/repositories/category/category_repository.dart';
import 'package:wts_test/repositories/product_details/abstract_product_details_repository.dart';
import 'package:wts_test/repositories/product_details/product_details_repository.dart';
import 'package:wts_test/repositories/product_list/abstract_product_list_repository.dart';
import 'package:wts_test/repositories/product_list/product_list_repository.dart';

final GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton<BaseApi>(() => BaseApi(dio: Dio()));
  locator.registerLazySingleton<AbstractCategoryRepository>(CategoryRepository.new);
  locator.registerLazySingleton<AbstractProductListRepository>(ProductListRepository.new);
  locator.registerLazySingleton<AbstractProductDetailsRepository>(ProductDetailsRepository.new);
}