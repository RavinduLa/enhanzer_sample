/*
* Created by Ravindu Wataketiya
* Login Repository
* Abstract class for Login Repository
* */

import 'package:either_dart/either.dart';

import '../../app_commons/exceptions/login_exception.dart';

abstract class LoginRepository {
  Future<Either<LoginException, bool>> login(
    String companyCode,
    String password,
  );
}
