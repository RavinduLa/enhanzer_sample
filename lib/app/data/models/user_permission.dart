import '../../domain/entity/permission_status.dart';
import '../../domain/entity/user_permission_entity.dart';

class UserPermission extends UserPermissionEntity {
  UserPermission({
    required super.permissionName,
    required super.permissionStatus,
  });

  UserPermission copyWith({
    String? permissonName,
    PermissionStatus? permissionStatus,
  }) =>
      UserPermission(
        permissionName: permissonName ?? permissionName,
        permissionStatus: permissionStatus ?? this.permissionStatus,
      );

  factory UserPermission.fromJson(Map<String, dynamic> json) => UserPermission(
    permissionName: json["Permisson_Name"],
    permissionStatus: permissionStatusValues.map[json["Permission_Status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "Permisson_Name": permissionName,
    "Permission_Status": permissionStatusValues.reverse[permissionStatus],
  };
}
