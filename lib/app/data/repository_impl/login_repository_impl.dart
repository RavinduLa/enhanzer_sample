/*
* Created by Ravindu Wataketiya
* Login Repository Implementation
* Handles the login method call from the user
* */

import 'package:either_dart/either.dart';

import '../../app_commons/exceptions/login_exception.dart';
import '../../domain/repository/login_repository.dart';


class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<LoginException, bool>> login(String companyCode, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

}