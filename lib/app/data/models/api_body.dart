class ApiBody {
  String uniqueId;
  String pw;

  ApiBody({
    required this.uniqueId,
    required this.pw,
  });

  ApiBody copyWith({
    String? uniqueId,
    String? pw,
  }) =>
      ApiBody(
        uniqueId: uniqueId ?? this.uniqueId,
        pw: pw ?? this.pw,
      );

  factory ApiBody.fromJson(Map<String, dynamic> json) => ApiBody(
        uniqueId: json["Unique_Id"],
        pw: json["Pw"],
      );

  Map<String, dynamic> toJson() => {
        "Unique_Id": uniqueId,
        "Pw": pw,
      };
}
