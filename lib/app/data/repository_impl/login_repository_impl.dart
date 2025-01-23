/*
* Created by Ravindu Wataketiya
* Login Repository Implementation
* Handles the login method call from the user
* */

import 'package:either_dart/either.dart';
import 'package:enhanzer_sample/app/data/local/sqflite_service.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../models/api_body.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../models/response_body.dart';
import '../remote/login_rest_client.dart';

import '../../app_commons/exceptions/login_exception.dart';
import '../../domain/repository/login_repository.dart';

class LoginRepositoryImpl extends GetxService implements LoginRepository {
  final LoginRestClient loginRestClient = Get.find<LoginRestClient>();

  //Login method
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
      //Make remote request
      LoginResponse response = await loginRestClient.login(loginRequest);
      if (response.statusCode == 200) {
        //Status code ok.
        if (response.responseBody != null) {
          //Response body is not null
          //Get response body
          ResponseBody responseBody = response.responseBody!.first;
          //Check if password is invalid and handle
          if (responseBody.docMessage == "Invalid Password") {
            return Left(
              LoginException(
                errorType: LoginExceptionType.invalidCredentials,
              ),
            );
          } else {
            //Login call is successful
            //Save data to SQFlite
            _saveLoginDataLocally(response);
            //Return right
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
        //Any other server status is considered as an error
        return Left(
          LoginException(
            errorType: LoginExceptionType.serverResponseError,
            message: "Error in server response.",
          ),
        );
      }
    } catch (e) {
      //Catch all other exceptions
      return Left(
        LoginException(
          errorType: LoginExceptionType.unknown,
          message: "Unknown error",
        ),
      );
    }
    //Return an unknown error
    return Left(
      LoginException(
        errorType: LoginExceptionType.unknown,
        message: "Unknown error",
      ),
    );
  }

  //Method to save data to SQFlite
  Future<void> _saveLoginDataLocally(LoginResponse loginResponse) async {
    final SQFLiteService sqfLiteService = Get.find<SQFLiteService>();
    try {
    } on DatabaseException {
      return;
    } catch (e) {
      return;
    }
  }
}
