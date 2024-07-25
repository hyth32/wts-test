import 'dart:developer';

import 'package:wts_test/api/entities/api_response_meta.dart';

/// Инкапсулирует ответ серверного API.
/// Содержит информацию:
/// - о результатах ответа запроса
/// - ошибки
/// - или разобранный JSON
class BaseApiResponse<T> {
  ApiResponseMeta? meta;
  String? rawData;
  dynamic dataJson;
  bool isSuccess;
  int? statusCode;
  String? error;

  BaseApiResponse({
    this.meta,
    this.rawData,
    this.isSuccess = false,
    this.dataJson,
    this.statusCode,
    this.error,
  }) {
    if (rawData != null) {
    } else {
      log('No server response');
    }
    if (isError) {
      log('Error: $error');
    }
  }

  bool get isError => error != null;
}
