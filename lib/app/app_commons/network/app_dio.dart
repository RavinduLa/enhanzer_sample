/*
* Created by Ravindu Wataketiya
* AppDio
* Central point for handling dio related logic.
* */

import 'package:dio/dio.dart';

import '../constants/url_constants.dart';

class AppDio {
  final dio = Dio(
    BaseOptions(
      baseUrl: UrlConstants.baseUrl,
    ),
  );

  Dio getDio() {
    dio.options.headers['Accept'] = "application/json";
    return dio;
  }
}
