import 'dart:convert';

import 'api_body.dart';

LoginRequest loginRequestFromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  List<ApiBody> apiBody;
  String apiAction;
  String companyCode;

  LoginRequest({
    required this.apiBody,
    required this.apiAction,
    required this.companyCode,
  });

  LoginRequest copyWith({
    List<ApiBody>? apiBody,
    String? apiAction,
    String? companyCode,
  }) =>
      LoginRequest(
        apiBody: apiBody ?? this.apiBody,
        apiAction: apiAction ?? this.apiAction,
        companyCode: companyCode ?? this.companyCode,
      );

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        apiBody: List<ApiBody>.from(
            json["API_Body"].map((x) => ApiBody.fromJson(x))),
        apiAction: json["Api_Action"],
        companyCode: json["Company_Code"],
      );

  Map<String, dynamic> toJson() => {
        "API_Body": List<dynamic>.from(apiBody.map((x) => x.toJson())),
        "Api_Action": apiAction,
        "Company_Code": companyCode,
      };
}
