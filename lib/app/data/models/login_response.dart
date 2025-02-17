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
  String? syncTime;
  String message;
  List<ResponseBody>? responseBody;

  LoginResponse({
    required this.statusCode,
    this.syncTime,
    required this.message,
    this.responseBody,
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
        responseBody: json["Response_Body"] != null
            ? List<ResponseBody>.from(
                json["Response_Body"].map((x) => ResponseBody.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "Status_Code": statusCode,
        "Sync_Time": syncTime,
        "Message": message,
        "Response_Body": responseBody != null
            ? List<dynamic>.from(responseBody!.map((x) => x.toJson()))
            : null,
      };
}
