import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
        queryParameters
    );
  }

  Future<dynamic> get(
      String path, {
      Map<String, dynamic>? queryParameters,
  }) async {
    var uri = buildUri(relativePath: path, queryParameters: queryParameters);
    queryParameters ??= {};
    queryParameters['appKey'] = Config.appKey;
    try {
      final response = await dio.get(
          uri.toString(),
          queryParameters: queryParameters,
      );
      final data = response.data['data'];
      return data;
    } catch (e) {
      debugPrint('Exception: $e');
      return [];
    }
  }
}
