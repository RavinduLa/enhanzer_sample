/*
* Created by Ravindu Wataketiya
* SQFLite Service
* Service class handling SQFLite operations
* */


import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../../app_commons/constants/sqflite_constants.dart';
import '../models/login_response.dart';
import '../models/response_body.dart';
import '../models/user_location.dart';
import '../models/user_permission.dart';

class SQFLiteService extends GetxService {
  late Database database;

  Future<SQFLiteService> init() async {
    await _initializeDB();
    await _initializeTables();
    return this;
  }

  Future<void> _initializeDB() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(
      databasesPath,
      SQFLiteConstants.dbName,
    );

    //Open the DB
    database = await openDatabase(path);
  }

  Future<void> _initializeTables() async {
    //Login Success Info Table
    if (await _tableExists(SQFLiteConstants.loginSuccessTable) == false) {
      //Create login success table
      await _createLoginSuccessInfoTable();
    }
    if (await _tableExists(SQFLiteConstants.userLocationsTable) == false) {
      //Create user locations table
      await _createUserLocationsTable();
    }
    if (await _tableExists(SQFLiteConstants.userPermissionsTable) == false) {
      //Create User permissions table
      await _createUserPermissionsTable();
    }
  }

  Future<void> _createLoginSuccessInfoTable() async {
    String tableName = SQFLiteConstants.loginSuccessTable;

    String id = SQFLiteConstants.columnId;
    String statusCode = SQFLiteConstants.columnStatusCode;
    String syncTime = SQFLiteConstants.columnSyncTime;
    String message = SQFLiteConstants.columnMessage;
    String userCode = SQFLiteConstants.columnUserCode;
    String userDisplayName = SQFLiteConstants.columnUserDisplayName;
    String email = SQFLiteConstants.columnEmail;
    String userEmployeeCode = SQFLiteConstants.columnUserEmployeeCode;
    String companyCode = SQFLiteConstants.columnCompanyCode;

    await database.execute(
        "CREATE TABLE $tableName ($id INTEGER PRIMARY KEY, $statusCode INTEGER, $syncTime TEXT, $message TEXT, $userCode TEXT, $userDisplayName TEXT, $email TEXT, $userEmployeeCode TEXT, $companyCode TEXT)");
  }

  Future<void> _createUserLocationsTable() async {
    String tableName = SQFLiteConstants.userLocationsTable;
    String userLocations = SQFLiteConstants.columnLocationCode;

    await database.execute("CREATE TABLE $tableName ($userLocations TEXT)");
  }

  Future<void> _createUserPermissionsTable() async {
    String tableName = SQFLiteConstants.userPermissionsTable;
    String permissionNameCol = SQFLiteConstants.columnPermissionName;
    String permissionStatusCol = SQFLiteConstants.columnPermissionStatus;

    await database.execute(
        "CREATE TABLE $tableName ($permissionNameCol TEXT, $permissionStatusCol TEXT)");
  }

  Future<bool> _tableExists(String tableName) async {
    String checkExistTable =
        "SELECT * FROM sqlite_master WHERE name ='$tableName' and type='table'";
    var checkExist = await database.rawQuery(checkExistTable);
    if (checkExist.isNotEmpty) {
      //Table is not empty, table exists
      return true;
    } else {
      //Table does not exist
      return false;
    }
  }

  Future<void> insertDataUponLogin(LoginResponse loginResponse) async {
    if (loginResponse.responseBody != null) {
      ResponseBody responseBody = loginResponse.responseBody!.first;
      if (responseBody.userLocations != null &&
          responseBody.userPermissions != null) {
        await _insertDataToLoginSuccessInfoTable(
          statusCode: loginResponse.statusCode,
          syncTime: loginResponse.syncTime!,
          message: loginResponse.message,
          responseBody: responseBody,
        );
        await _insertDataToUserLocationsTable(responseBody.userLocations!);
        await _insertDataToUserPermissionsTable(responseBody.userPermissions!);
      }
    }
  }

  Future<void> _insertDataToLoginSuccessInfoTable(
      {required int statusCode,
      required String syncTime,
      required String message,
      required ResponseBody responseBody}) async {
    String tableName = SQFLiteConstants.loginSuccessTable;

    String id = SQFLiteConstants.columnId;
    String statusCodeCol = SQFLiteConstants.columnStatusCode;
    String syncTimeCol = SQFLiteConstants.columnSyncTime;
    String messageCol = SQFLiteConstants.columnMessage;
    String userCodeCol = SQFLiteConstants.columnUserCode;
    String userDisplayNameCol = SQFLiteConstants.columnUserDisplayName;
    String emailCol = SQFLiteConstants.columnEmail;
    String userEmployeeCodeCol = SQFLiteConstants.columnUserEmployeeCode;
    String companyCodeCol = SQFLiteConstants.columnCompanyCode;

    String queryLine1 =
        "INSERT INTO $tableName ($id, $statusCodeCol, $syncTimeCol, $messageCol, $userCodeCol, $userDisplayNameCol, $emailCol, $userEmployeeCodeCol, $companyCodeCol)";
    String queryLine2 =
        "VALUES (1, $statusCode, $syncTime, $message, ${responseBody.userCode}, ${responseBody.userDisplayName}, ${responseBody.email}, ${responseBody.userEmployeeCode}, ${responseBody.companyCode})";
    String fullQuery = queryLine1 + queryLine2;

    await database.rawInsert(fullQuery);
  }

  Future<void> _insertDataToUserLocationsTable(
      List<UserLocation> userLocations) async {
    String tableName = SQFLiteConstants.userLocationsTable;

    String userLocationCodeCol = SQFLiteConstants.columnLocationCode;

    for (UserLocation location in userLocations) {
      String queryLine1 = "INSERT INTO $tableName ($userLocationCodeCol)";
      String queryLine2 = "VALUES (${location.locationCode})";
      String fullQuery = queryLine1 + queryLine2;

      await database.rawInsert(fullQuery);
    }
  }

  Future<void> _insertDataToUserPermissionsTable(
      List<UserPermission> userPermissions) async {
    String tableName = SQFLiteConstants.userPermissionsTable;

    String permissionNameCol = SQFLiteConstants.columnPermissionName;
    String permissionStatusCol = SQFLiteConstants.columnPermissionStatus;

    for (UserPermission permission in userPermissions) {
      String queryLine1 =
          "INSERT INTO $tableName ($permissionNameCol, $permissionStatusCol)";
      String queryLine2 =
          "VALUES (${permission.permissionName}, ${permission.permissionStatus})";
      String fullQuery = queryLine1 + queryLine2;

      await database.rawInsert(fullQuery);
    }
  }
}
