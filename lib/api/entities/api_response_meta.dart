import 'package:json_annotation/json_annotation.dart';

part 'api_response_meta.g.dart';

/// Часть стандартного ответа любого API.
/// Содержит информацию о том:
/// - успешный ли запрос
/// - есть ли какая-то ошибка с сервера (ошибка валидаци данных или выполнения метода API)
@JsonSerializable()
class ApiResponseMeta {
  final String? error;
  final bool? invalidAccessToken;
  final bool success;

  ApiResponseMeta({
    this.error,
    this.invalidAccessToken,
    this.success = false,
  });

  factory ApiResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseMetaFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseMetaToJson(this);
}
