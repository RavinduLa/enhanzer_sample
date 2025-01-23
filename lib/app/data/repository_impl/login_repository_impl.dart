/*
* Created by Ravindu Wataketiya
* Login Repository Implementation
* Handles the login method call from the user
* */

import 'package:either_dart/either.dart';
import 'package:get/get.dart';

import '../models/api_body.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/response_body.dart';
import '../remote/login_rest_client.dart';

import '../../app_commons/exceptions/login_exception.dart';
import '../../domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRestClient loginRestClient = Get.find<LoginRestClient>();

  @override
  Future<Either<LoginException, bool>> login(
      String companyCode, String password) async {
    ApiBody apiBody = ApiBody(
      uniqueId: "uniqueId",
      pw: password,
    );
    List<ApiBody> apiBodies = [];
    apiBodies.add(apiBody);
    String apiAction = "GetUserData";

    //Create login request
    LoginRequest loginRequest = LoginRequest(
      apiBody: apiBodies,
      apiAction: apiAction,
      companyCode: companyCode,
    );

    try {
      LoginResponse response = await loginRestClient.login(loginRequest);
      if (response.statusCode == 200) {
        if (response.responseBody != null) {
          ResponseBody responseBody = response.responseBody!.first;
          if (responseBody.docMessage == "Invalid Password") {
            return Left(
              LoginException(
                errorType: LoginExceptionType.invalidCredentials,
              ),
            );
          } else {
            return Right(true);
          }
        }
      } else if (response.statusCode == 401) {
        //Unauthorized request
        return Left(
          LoginException(
            errorType: LoginExceptionType.invalidCredentials,
          ),
        );
      } else {
        return Left(
          LoginException(
            errorType: LoginExceptionType.serverResponseError,
            message: "Error in server response.",
          ),
        );
      }
    } on LoginException catch (e) {
      return Left(
        LoginException(
          errorType: LoginExceptionType.unknown,
          message: "Error in server response.",
        ),
      );
    }
    return Left(
      LoginException(
        errorType: LoginExceptionType.unknown,
        message: "Unknown error",
      ),
    );
  }
}
