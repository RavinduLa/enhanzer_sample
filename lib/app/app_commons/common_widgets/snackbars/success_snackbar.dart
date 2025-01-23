/*
* Created by Ravindu Wataketiya
* Success snackbar
* Common snackbar to show in success scenarios
* */

import 'package:get/get.dart';

import '../../defaults/snackbar_defaults.dart';
import 'snackbars.dart';

class SuccessSnackBar implements CustomGetSnackBar {
  const SuccessSnackBar({
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
