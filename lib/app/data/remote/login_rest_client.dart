/*
* Created by Ravindu Wataketiya
* Login_REST_Client
* Retrofit REST client for login
* */

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/login_request.dart';
import '../models/login_response.dart';

part 'login_rest_client.g.dart';

@RestApi()
abstract class LoginRestClient {
  factory LoginRestClient (Dio dio, {String? baseUrl}) = _LoginRestClient;

  //Perform Login
  @POST('/api/External_Api/Mobile_Api/Invoke')
  Future<LoginResponse> login(
    @Body() LoginRequest request,
  );
}
