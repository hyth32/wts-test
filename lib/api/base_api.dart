import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BaseApi {
  BaseApi({required this.dio});

  final Dio dio;

  String baseURL = 'onlinestore.whitetigersoft.ru';

  //flutter run --dart-define=APP_KEY=''
  // String appKey = const String.fromEnvironment('APP_KEY');
  String appKey = 'EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um';

  Uri buildUri({
    required String relativePath,
    Map<String, dynamic>? queryParameters,
  }) {
    return Uri.http(
      baseURL,
        'api/$relativePath',
        queryParameters
    );
  }

  Future<dynamic> get(
      String path, {
      Map<String, dynamic>? queryParameters,
  }) async {
    var uri = buildUri(relativePath: path);
    queryParameters ??= {};
    queryParameters['appKey'] = appKey;
    try {
      final response = await dio.get(
          uri.toString(),
          queryParameters: queryParameters
      );
      final data = response.data['data'];
      return data;
    } catch (e) {
      debugPrint('Exception: $e');
      return [];
    }
  }
}
