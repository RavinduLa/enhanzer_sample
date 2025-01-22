/*
* Created by Ravindu Wataketiya
* User Permission Entity
* Entity class for user permission
* */

import 'permission_status.dart';

class UserPermissionEntity {
  String permissionName;
  PermissionStatus permissionStatus;

  UserPermissionEntity({
    required this.permissionName,
    required this.permissionStatus,
  });
}