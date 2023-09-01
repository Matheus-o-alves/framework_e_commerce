// ignore_for_file: file_names

import '../../data/http/http_client.dart';
import '../../data/http/http_error.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  final HttpClient decoratee;

  AuthorizeHttpClientDecorator({
    required this.decoratee,
  });

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
  }) async {
    try {
      final authorizedHeaders = headers ?? {}
        ..addAll({'Authorization': 'Bearer '});
      final response = await decoratee.request(
          url: url, method: method, body: body, headers: authorizedHeaders);

      return response;
    } catch (error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      } else {
        throw HttpError.forbidden;
      }
    }
  }
}
