import 'package:json_annotation/json_annotation.dart';

class BoolJsonConverter extends JsonConverter<bool, int?> {
  const BoolJsonConverter();

  @override
  bool fromJson(int? json) {
    if (json == null) return false;
    return json == 1;
  }

  @override
  int? toJson(bool object) {
    return object ? 1 : 0;
  }
}
