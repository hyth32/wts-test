import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wts_test/api/entities/api_response.dart';
import 'package:wts_test/api/entities/api_response_meta.dart';
import 'package:wts_test/api/entities/base_api_response.dart';

/// Утилитарный класс для парсинга ответа сервера.
/// Позволяет парсить список сущностей, возвращенных с сервера.
/// А также одну сущность, возвращенную с сервера.
class ApiResponseParser {
  static const String defaultErrorMessage = 'Произошла неизвестная ошибка.';

  static BaseApiResponse parseRawResponse(Response response, [String? key]) {
    return _parseBasicBody(response, key);
  }

  static BaseApiResponse _parseBasicBody(Response response, [String? key]) {
    var responseData = response.data['data'];
    var responseMeta = response.data['meta'];
    if (key != null) {
      responseData = responseData[key];
    }
    if (responseData == null) {
      return BaseApiResponse(
        error: defaultErrorMessage,
        statusCode: response.statusCode,
      );
    }
    if (responseData == null) {
      return BaseApiResponse(
        error: 'Не удалось получить data часть запроса',
        rawData: responseData.toString(),
      );
    }
    try {
      var apiResponseMeta = ApiResponseMeta.fromJson(responseMeta);

      if (!apiResponseMeta.success) {
        return BaseApiResponse(
          error: apiResponseMeta.error,
          meta: apiResponseMeta,
          rawData: responseData.toString(),
        );
      }

      return BaseApiResponse(
        dataJson: responseData,
        meta: apiResponseMeta,
        rawData: responseData.toString(),
      );
    } catch (e) {
      return BaseApiResponse(
        error: 'Не удалось разобрать meta часть запроса',
        rawData: responseData.toString(),
      );
    }
  }

  /// Парсинг списка объектов из результата выполненного запроса к API.
  static ApiResponse<List<T>> parseListFromResponse<T>(
    BaseApiResponse response, {
    String? key,
    required T Function(Map<String, dynamic>) fromJson,
    String? emptyError,
  }) {
    try {
      if (response.isError) {
        return ApiResponse.error(
          error: response.error!,
          baseApiResponse: response,
        );
      }

      var jsonData = (key?.isNotEmpty ?? false)
          ? response.dataJson[key]
          : response.dataJson;
      if (jsonData == null) {
        return ApiResponse.error(
          error: 'Данные не найдены',
          baseApiResponse: response,
        );
      }
      final list = (jsonData as List).map((e) => fromJson(e)).toList();
      return ApiResponse(
        data: list,
        baseApiResponse: response,
      );
    } catch (e, s) {
      log('[Error] parseListFromResponse', error: e, stackTrace: s);
      return ApiResponse.error(
        error: defaultErrorMessage,
        baseApiResponse: response,
      );
    }
  }

  /// Парсинг одного объекта из результата выполненного запроса к API.
  static ApiResponse<T> parseObjectFromResponse<T>(
    BaseApiResponse response, {
    String? key,
    required T Function(Map<String, dynamic>) fromJson,
    String? emptyError,
  }) {
    try {
      if (response.isError) {
        return ApiResponse.error(
          error: response.error!,
          baseApiResponse: response,
        );
      }

      var jsonData = (key?.isNotEmpty ?? false)
          ? response.dataJson[key]
          : response.dataJson;
      if (jsonData == null) {
        return ApiResponse.error(
          error: emptyError ?? 'Данные не найдены',
          baseApiResponse: response,
        );
      }
      final object = fromJson(jsonData);
      return ApiResponse(
        data: object,
        baseApiResponse: response,
      );
    } catch (e, s) {
      log('[Error] parseObjectFromResponse', error: e, stackTrace: s);
      return ApiResponse.error(
        error: defaultErrorMessage,
        baseApiResponse: response,
      );
    }
  }
}
