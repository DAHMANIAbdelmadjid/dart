import 'package:json_annotation/json_annotation.dart';
import 'package:tabibi_2/domain/models/city.dart';
import 'package:tabibi_2/domain/models/doctor.dart';

part 'response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'data')
  String? token;

  LoginResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

class CitiesResponse {
  int? statusCode;
  bool? succeeded;
  String? message;
  String? error;
  List<CityResponse>? data;

  CitiesResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory CitiesResponse.fromJson(Map<String, dynamic> json) => CitiesResponse(
        statusCode: json["statusCode"],
        succeeded: json["succeeded"],
        message: json["message"],
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<CityResponse>.from(
                json["data"].map((x) => CityResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "succeeded": succeeded,
        "message": message,
        "error": error,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CityResponse {
  int? id;
  String? name;

  CityResponse({
    this.id,
    this.name,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) => CityResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  toDomain() => City(
        id: id ?? 0,
        name: name ?? '',
        country: '', // Provide a default or appropriate value for 'country'
      );
}

class DoctorsResponse {
  int? statusCode;
  bool? succeeded;
  String? message;
  String? error;
  List<DoctorResponse>? data;

  DoctorsResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory DoctorsResponse.fromJson(Map<String, dynamic> json) =>
      DoctorsResponse(
        statusCode: json["statusCode"],
        succeeded: json["succeeded"],
        message: json["message"],
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<DoctorResponse>.from(
                json["data"].map((x) => DoctorResponse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "succeeded": succeeded,
        "message": message,
        "error": error,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DoctorResponse {
  int? id;
  String? name;
  String? specialty;
  String? imageUrl;
  String? city;
  double? rating;

  DoctorResponse({
    this.id,
    this.name,
    this.specialty,
    this.imageUrl,
    this.city,
    this.rating,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) => DoctorResponse(
        id: json["id"],
        name: json["name"],
        specialty: json["specialty"],
        imageUrl: json["imageUrl"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "specialty": specialty,
        "imageUrl": imageUrl,
        "city": city,
        "rating": rating,
      };

  toDomain() => Doctor(
        id: id ?? 0,
        name: name ?? '',
        specialty: specialty ?? '',
        imageUrl: imageUrl ?? '',
        city: city ?? '',
        rating: rating ?? 0.0,
        address: '', // Provide a default or appropriate value for 'address'
      );
}
