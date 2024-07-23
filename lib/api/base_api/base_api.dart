import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wts_test/api/base_api/base_api_request.dart';
import 'package:wts_test/config.dart';

class BaseApi {
  BaseApi({required this.dio});

  final Dio dio;

  Uri buildUri({
    required String relativePath,
    Map<String, dynamic>? queryParameters,
  }) {
    return Uri.http(
      Config.baseUrl,
      'api/$relativePath',
      queryParameters,
    );
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    var uri = buildUri(
      relativePath: path,
      queryParameters: queryParameters,
    );
    queryParameters ??= {};
    queryParameters['appKey'] = Config.appKey;
    try {
      final response = await dio.get(
        uri.toString(),
        queryParameters: queryParameters,
      );
      final responseData = response.data as Map<String, dynamic>;
      final meta = ApiResponseMeta.fromJson (responseData['meta']);

      if (meta.success) {
        final data = responseData['data'];
        return data;
      }
      return [];
    } catch (e) {
      debugPrint('Exception: $e');
      return [];
    }
  }
}