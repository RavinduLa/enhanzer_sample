import 'package:enhanzer_sample/app/data/local/sqflite_service.dart';
import 'package:get/get.dart';

import 'data/repository_impl/login_repository_impl.dart';
import 'domain/repository/login_repository.dart';
import 'app_commons/network/app_dio.dart';
import 'data/remote/login_rest_client.dart';

class InitialBindings {
  InitialBindings() {
    Get.putAsync(() => SQFLiteService().init());
    Get.put<LoginRestClient>(LoginRestClient(AppDio().getDio()));
    Get.put<LoginRepository>(LoginRepositoryImpl());
  }
}
