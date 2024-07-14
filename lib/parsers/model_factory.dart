abstract class JsonParser<T> {
  T fromJson(Map<String, dynamic> json);
}

class ModelFactory {
  static T createModel<T>(Map<String, dynamic> json, JsonParser<T> parser) {
    return parser.fromJson(json);
  }
}