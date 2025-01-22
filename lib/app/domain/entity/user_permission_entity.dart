import 'permission_status.dart';

class UserPermissionEntity {
  String permissionName;
  PermissionStatus permissionStatus;

  UserPermissionEntity({
    required this.permissionName,
    required this.permissionStatus,
  });
}