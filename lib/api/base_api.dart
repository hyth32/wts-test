import 'package:dio/dio.dart';

class BaseApi {
  BaseApi({required this.dio});

  final Dio dio;

  String baseURL = 'http://onlinestore.whitetigersoft.ru/api';

  //flutter run --dart-define=APP_KEY=''
  // String appKey = const String.fromEnvironment('APP_KEY');
  String appKey = 'EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um';

  Future<dynamic> get(String path, {String? param}) async {
    String finalURL = '$baseURL/$path?';

    if (param != null) {
      finalURL += '$param&';
    }
    finalURL += 'appKey=$appKey';

    final response = await dio.get(finalURL);
    final data = response.data['data'];
    return data;
  }

  Future<dynamic> post(String path, dynamic data) async {
    String finalURL = '$baseURL/$path?';
    final response = await dio.post(finalURL, data: data);
    return response.data['data'];
  }
}
