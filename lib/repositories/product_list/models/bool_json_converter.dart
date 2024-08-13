
// TODO: наследовать от JsonConverter<bool, int?>
class BoolJsonConverter {
  final dynamic fromJson;
  final bool? fromBool;

  BoolJsonConverter(this.fromBool, this.fromJson);

  static int toInt(json) {
    try {
      if (json is! int) {
        return int.parse(json);
      }
      return json;
    } catch (e) {
      return -1;
    }
  }

  static bool toBool(json) {
    final jsonToInt = toInt(json);
    return jsonToInt == 1;
  }
}
