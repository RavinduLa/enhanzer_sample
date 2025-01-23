/*
* Created by Ravindu Wataketiya
* Failure snackbar
* Common snackbar to show in failure scenarios
* */


import 'package:get/get.dart';

import '../../defaults/snackbar_defaults.dart';
import 'snackbars.dart';

class FailureSnackBar implements CustomGetSnackBar {
  const FailureSnackBar({
    required this.title,
    required this.message,
    this.onTap,
    this.position,
  });

  final String title;
  final String message;
  final Function(GetSnackBar)? onTap;
  final SnackPosition? position;

  @override
  void show() {
    Get.snackbar(
      title,
      message,
      onTap: onTap,
      snackPosition: position ?? defaultSnackPosition,
    );
  }
}