import 'package:json_annotation/json_annotation.dart';

part 'base_api_request.g.dart';

@JsonSerializable()
class ApiResponseMeta {
  ApiResponseMeta({
    required this.success,
    required this.error,
  });

  final bool success;
  final String error;

  factory ApiResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseMetaFromJson(json);
}