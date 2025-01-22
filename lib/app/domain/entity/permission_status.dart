/*
* Created by Ravindu Wataketiya
* Permission status
* Enumeration to handle permission status
* */

enum PermissionStatus { ENABLE }

final permissionStatusValues = EnumValues({"Enable": PermissionStatus.ENABLE});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
