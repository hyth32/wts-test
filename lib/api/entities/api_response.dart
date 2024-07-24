import 'package:wts_test/api/entities/base_api_response.dart';

/// Объект для возврата результата выполнения запроса к API.
/// Любой внешний метод для вызова серверного метода API,
/// должен возвращать объект такого формата.
/// Кроме данных, которые есть в [BaseApiResponse], также содержит уже разобранные из JSON данные (тип [T]).
/// Обычно [T] это:
/// - Список сущностей - для методов загрузки списков данных с сервера, например, список публикаций в блоге: List<Post>
/// - Одна сущность - для методов загрузки одной сущности с сервера, например, профиль пользователя: User
/// - [bool] - для методов - действий, например, "лайкнуть публикацю", "удалить публикацию"
class ApiResponse<T> extends BaseApiResponse {
  T? result;

  ApiResponse({
    BaseApiResponse? baseApiResponse,
    this.result,
  }) : super(
          meta: baseApiResponse?.meta,
          rawData: baseApiResponse?.rawData,
          dataJson: baseApiResponse?.dataJson,
          error: baseApiResponse?.error,
          statusCode: baseApiResponse?.statusCode,
          isSuccess: baseApiResponse?.isSuccess ?? true,
        );

  ApiResponse.error({
    required String error,
    BaseApiResponse? baseApiResponse,
    String? errorCode,
  }) : super(
          error: error,
          statusCode: baseApiResponse?.statusCode,
          dataJson: baseApiResponse?.dataJson,
          rawData: baseApiResponse?.rawData,
        );
}
