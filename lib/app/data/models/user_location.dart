/*
* Created by Ravindu Wataketiya
* User Location
* Model for user location, extends UserLocationEntity
* */

import '../../domain/entity/user_location_entity.dart';

class UserLocation extends UserLocationEntity {
  UserLocation({
    required super.locationCode,
  });

  UserLocation copyWith({
    String? locationCode,
  }) =>
      UserLocation(
        locationCode: locationCode ?? this.locationCode,
      );

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        locationCode: json["Location_Code"],
      );

  Map<String, dynamic> toJson() => {
        "Location_Code": locationCode,
      };
}
