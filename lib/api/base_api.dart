import 'package:dio/dio.dart';

class BaseApi {
  BaseApi({required this.dio});

  final Dio dio;

  String baseURL = 'http://onlinestore.whitetigersoft.ru/api';

  //start with flutter run --dart-define=APP_KEY=''
  // String appKey = const String.fromEnvironment('APP_KEY');
  String appKey = 'EyZ6DhtHN24DjRJofNZ7BijpNsAZ-TT1is4WbJb9DB7m83rNQCZ7US0LyUg5FCP4eoyUZXmM1z45hY5fIC-JTCgmqHgnfcevkQQpmxi8biwwlSn0zZedvlNh0QkP1-Um';

  Future<dynamic> get(String path, {int? categoryId}) async {
    String finalURL = '$baseURL/$path?';
    if (categoryId != null) {
      finalURL += 'categoryId=$categoryId&';
    }
    finalURL += 'appKey=$appKey';
    final response = await dio.get(finalURL);
    final data = response.data['data'];
    return data;
  }
}
