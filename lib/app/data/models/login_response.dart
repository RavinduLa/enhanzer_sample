/*
* Created by Ravindu Wataketiya
* Login Response
* Response model for login
* */

import 'response_body.dart';

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int statusCode;
  String syncTime;
  String message;
  List<ResponseBody> responseBody;

  LoginResponse({
    required this.statusCode,
    required this.syncTime,
    required this.message,
    required this.responseBody,
  });

  LoginResponse copyWith({
    int? statusCode,
    String? syncTime,
    String? message,
    List<ResponseBody>? responseBody,
  }) =>
      LoginResponse(
        statusCode: statusCode ?? this.statusCode,
        syncTime: syncTime ?? this.syncTime,
        message: message ?? this.message,
        responseBody: responseBody ?? this.responseBody,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        statusCode: json["Status_Code"],
        syncTime: json["Sync_Time"],
        message: json["Message"],
        responseBody: List<ResponseBody>.from(
            json["Response_Body"].map((x) => ResponseBody.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status_Code": statusCode,
        "Sync_Time": syncTime,
        "Message": message,
        "Response_Body":
            List<dynamic>.from(responseBody.map((x) => x.toJson())),
      };
}
