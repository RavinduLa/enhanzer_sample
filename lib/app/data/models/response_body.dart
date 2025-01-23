/*
* Created by Ravindu Wataketiya
* Response body
* Model for response body for login.
* */

import 'user_location.dart';
import 'user_permission.dart';

class ResponseBody {
  String? userCode;
  String? userDisplayName;
  String email;
  String? userEmployeeCode;
  String? companyCode;
  String? docMessage;
  List<UserLocation>? userLocations;
  List<UserPermission>? userPermissions;

  ResponseBody({
    this.userCode,
    this.userDisplayName,
    required this.email,
    this.userEmployeeCode,
    this.companyCode,
    this.userLocations,
    this.userPermissions,
    this.docMessage,
  });

  ResponseBody copyWith({
    String? userCode,
    String? userDisplayName,
    String? email,
    String? userEmployeeCode,
    String? companyCode,
    String? docMessage,
    List<UserLocation>? userLocations,
    List<UserPermission>? userPermissions,
  }) =>
      ResponseBody(
        userCode: userCode ?? this.userCode,
        userDisplayName: userDisplayName ?? this.userDisplayName,
        email: email ?? this.email,
        userEmployeeCode: userEmployeeCode ?? this.userEmployeeCode,
        companyCode: companyCode ?? this.companyCode,
        docMessage: docMessage ?? this.docMessage,
        userLocations: userLocations ?? this.userLocations,
        userPermissions: userPermissions ?? this.userPermissions,
      );

  factory ResponseBody.fromJson(Map<String, dynamic> json) => ResponseBody(
        userCode: json["User_Code"],
        userDisplayName: json["User_Display_Name"],
        email: json["Email"],
        userEmployeeCode: json["User_Employee_Code"],
        companyCode: json["Company_Code"],
        docMessage: json["Doc_Msg"],
        userLocations: json["User_Locations"] != null ? List<UserLocation>.from(
            json["User_Locations"].map((x) => UserLocation.fromJson(x))) : null,
        userPermissions: json["User_Permissions"] != null ?  List<UserPermission>.from(
            json["User_Permissions"].map((x) => UserPermission.fromJson(x))) : null,
      );

  Map<String, dynamic> toJson() => {
        "User_Code": userCode,
        "User_Display_Name": userDisplayName,
        "Email": email,
        "User_Employee_Code": userEmployeeCode,
        "Company_Code": companyCode,
        "Doc_Msg": docMessage,
        "User_Locations": userLocations != null
            ? List<dynamic>.from(userLocations!.map((x) => x.toJson()))
            : null,
        "User_Permissions": userPermissions != null
            ? List<dynamic>.from(userPermissions!.map((x) => x.toJson()))
            : null,
      };
}
