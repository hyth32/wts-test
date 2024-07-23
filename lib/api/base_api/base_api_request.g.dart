// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_api_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponseMeta _$ApiResponseMetaFromJson(Map<String, dynamic> json) =>
    ApiResponseMeta(
      success: json['success'] as bool,
      error: json['error'] as String,
    );

Map<String, dynamic> _$ApiResponseMetaToJson(ApiResponseMeta instance) =>
    <String, dynamic>{
      'success': instance.success,
      'error': instance.error,
    };
