/*
* Created by Ravindu Wataketiya
* AppDio
* Central point for handling dio related logic.
* */

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../constants/url_constants.dart';

class AppDio {
  final dio = Dio(
    BaseOptions(
      baseUrl: UrlConstants.baseUrl,
    ),
  );

  //Logger
  final Logger logger = Logger();

  Dio getDio() {
    dio.options.headers['Accept'] = "application/json";

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, requestInterceptHandler) async {
          return requestInterceptHandler.next(options);
        },
        onResponse: (response, responseInterceptHandler) async {
          return responseInterceptHandler.next(response);
        },
        onError: (DioException dioException,
            ErrorInterceptorHandler errorHandler) async {
          return errorHandler.next(dioException);
        },
      ),
    );

    return dio;
  }
}
