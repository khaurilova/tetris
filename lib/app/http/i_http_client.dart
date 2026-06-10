// base_url/5/tetris/lib/app/http/i_http_client.dart
import 'package:http/http.dart';

/// Интерфейс HTTP-клиента
/// Используется для отправки запросов на сервер
abstract interface class IHttpClient {
  /// Базовый URL для запросов
  String get baseUrl;

  /// Отправляет POST-запрос на указанный URL с телом запроса
  /// Возвращает ответ от сервера
  Future<Response> post(String url, {Object? body});

  /// Отправляет GET-запрос на указанный URL
  /// Возвращает ответ от сервера
  Future<Response> get(String url);

  /// Отправляет PUT-запрос на указанный URL с телом запроса
  /// Возвращает ответ от сервера
  Future<Response> put(String url, {Object? body});
}
