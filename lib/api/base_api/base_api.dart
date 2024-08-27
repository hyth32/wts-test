import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wts_test/api/api_response_parser.dart';
import 'package:wts_test/api/entities/base_api_response.dart';
import 'package:wts_test/config.dart';

class BaseApi {
  BaseApi({required this.dio});

  final Dio dio;

  Map<String, dynamic>? prepareQueryParameters(
    Map<String, dynamic>? queryParameters,
  ) {
    queryParameters ??= {};
    queryParameters['appKey'] = Config.appKey;
    return queryParameters;
  }

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

  Future<BaseApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final uri = buildUri(
      relativePath: path,
      queryParameters: queryParameters,
    );
    try {
      final response = await dio.get(
        uri.toString(),
        queryParameters: prepareQueryParameters(queryParameters),
      );
      return ApiResponseParser.parseRawResponse(response);
    } catch (e, s) {
      debugPrint('Exception: $e\n$s');
      return BaseApiResponse(
        error: e.toString(),
      );
    }
  }
}
