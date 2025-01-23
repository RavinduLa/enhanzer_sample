import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../app_commons/common_widgets/snackbars/failure_snackbar.dart';
import '../../../app_commons/common_widgets/snackbars/success_snackbar.dart';
import '../../../app_commons/exceptions/login_exception.dart';
import '../../../domain/repository/login_repository.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository = Get.find();

  RxBool isLoading = false.obs;
  final loginFormKey = GlobalKey<FormState>();
  final companyCodeController = TextEditingController();
  final passwordController = TextEditingController();
  final RxString loadingString = "Loading".obs;
  final RxBool passwordObscured = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onLoginTapped() async {
    bool formValid = validateForm();
    if (formValid) {
      isLoading.value = true;
      await _loginRemoteCall();
      isLoading.value = false;
    }
  }

  //Validate the form
  bool validateForm() {
    return loginFormKey.currentState!.validate();
  }

  //Change the visibility status of the password field
  void flipPasswordFieldVisibility() {
    passwordObscured.value = !passwordObscured.value;
  }

  Future<void> _loginRemoteCall() async {
    //Make call
    Either<LoginException, bool> result = await loginRepository.login(
      companyCodeController.text.trim(),
      passwordController.text.trim(),
    );

    //Handle result
    result.fold((left) {
      //Handle error
      _handleLoginError(left);
    }, (right) {
      //Handle success scenario
      _handleSuccess();
    });
  }

  //Handle success scenarios for login
  void _handleSuccess() async {
    _showSuccessSnackBar(
      "Success",
      "Your username and password are correct.",
    );
  }

  //Handle the error scenarios for login
  void _handleLoginError(LoginException exception) async {
    if (exception.errorType == LoginExceptionType.invalidCredentials) {
      _showFailureSnackBar(
        "Invalid credentials",
        "Either your username or password is invalid",
        null,
      );
    } else {
      _showFailureSnackBar(
        "Error",
        "An unknown error has occurred. Please try again and make sure you are connected to the internet.",
        null,
      );
    }
  }

  Future<void> _showFailureSnackBar(
    String title,
    String message,
    Function(GetSnackBar)? onTap,
  ) async {
    FailureSnackBar(
      title: title,
      message: message,
      onTap: onTap,
    ).show();
  }

  Future<void> _showSuccessSnackBar(
    String title,
    String message,
  ) async {
    SuccessSnackBar(
      title: title,
      message: message,
    ).show();
  }
}
