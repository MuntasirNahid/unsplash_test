import 'dart:collection';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:unsplash_image/models/error/errors.dart';
import 'package:unsplash_image/utils/logger.dart';

abstract class BaseRepository {
  static const String jsonContentType = 'application/json';
  static const String formUrlEncodedType = 'application/x-www-form-urlencoded';
  static const int maxRetryLoad = 2;

  SharedPreferences? prefs;

  final Logger _logger = Logger.getLogger((BaseRepository).toString());

  int retryCountPolicy = maxRetryLoad;

  BaseRepository() {
    loadPreferences();
  }

  void loadPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  HttpException parseHttpError(int statusCode, {String? message}) {
    switch (statusCode) {
      case HttpStatus.requestTimeout:
        return RequestTimeout(message ?? '');
      case HttpStatus.unauthorized:
        return UnauthorisedAccess(message ?? '');
      case HttpStatus.internalServerError:
        return ServerError(message ?? '');
      default:
        return HttpException(message ?? '');
    }
  }

  Map<String, String> prepareHeaders({
    String? bearerToken,
    bool accept = true,
    String? contentType,
  }) {
    HashMap<String, String> headers = HashMap();
    if (bearerToken != null) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }

    if (accept) {
      headers['Accept'] = 'application/json';
    }

    if (contentType != null) {
      headers['Content-Type'] = contentType;
    }

    return headers;
  }

  void clearRetryPolicy() {
    retryCountPolicy = maxRetryLoad;
  }
}
