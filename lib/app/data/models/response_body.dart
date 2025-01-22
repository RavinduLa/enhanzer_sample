import 'user_location.dart';
import 'user_permission.dart';

class ResponseBody {
  String userCode;
  String userDisplayName;
  String email;
  String userEmployeeCode;
  String companyCode;
  List<UserLocation> userLocations;
  List<UserPermission> userPermissions;

  ResponseBody({
    required this.userCode,
    required this.userDisplayName,
    required this.email,
    required this.userEmployeeCode,
    required this.companyCode,
    required this.userLocations,
    required this.userPermissions,
  });

  ResponseBody copyWith({
    String? userCode,
    String? userDisplayName,
    String? email,
    String? userEmployeeCode,
    String? companyCode,
    List<UserLocation>? userLocations,
    List<UserPermission>? userPermissions,
  }) =>
      ResponseBody(
        userCode: userCode ?? this.userCode,
        userDisplayName: userDisplayName ?? this.userDisplayName,
        email: email ?? this.email,
        userEmployeeCode: userEmployeeCode ?? this.userEmployeeCode,
        companyCode: companyCode ?? this.companyCode,
        userLocations: userLocations ?? this.userLocations,
        userPermissions: userPermissions ?? this.userPermissions,
      );

  factory ResponseBody.fromJson(Map<String, dynamic> json) => ResponseBody(
    userCode: json["User_Code"],
    userDisplayName: json["User_Display_Name"],
    email: json["Email"],
    userEmployeeCode: json["User_Employee_Code"],
    companyCode: json["Company_Code"],
    userLocations: List<UserLocation>.from(json["User_Locations"].map((x) => UserLocation.fromJson(x))),
    userPermissions: List<UserPermission>.from(json["User_Permissions"].map((x) => UserPermission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "User_Code": userCode,
    "User_Display_Name": userDisplayName,
    "Email": email,
    "User_Employee_Code": userEmployeeCode,
    "Company_Code": companyCode,
    "User_Locations": List<dynamic>.from(userLocations.map((x) => x.toJson())),
    "User_Permissions": List<dynamic>.from(userPermissions.map((x) => x.toJson())),
  };
}