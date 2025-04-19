import 'package:json_annotation/json_annotation.dart';
import 'package:tabibi_2/domain/models/doctor.dart';

part 'doctor_response.g.dart';

@JsonSerializable()
class DoctorResponse {
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'data')
  List<DoctorData>? data;

  DoctorResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory DoctorResponse.fromJson(Map<String, dynamic> json) =>
      _$DoctorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorResponseToJson(this);
}

@JsonSerializable()
class DoctorData {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'specialty')
  String? specialty;
  @JsonKey(name: 'imageUrl')
  String? imageUrl;
  @JsonKey(name: 'rating')
  double? rating;
  @JsonKey(name: 'city')
  String? city;
  @JsonKey(name: 'address')
  String? address;

  DoctorData({
    this.id,
    this.name,
    this.specialty,
    this.imageUrl,
    this.rating,
    this.city,
    this.address,
  });

  factory DoctorData.fromJson(Map<String, dynamic> json) =>
      _$DoctorDataFromJson(json);
  Map<String, dynamic> toJson() => _$DoctorDataToJson(this);

  Doctor toDomain() {
    return Doctor(
      id: id ?? 0,
      name: name ?? '',
      specialty: specialty ?? '',
      imageUrl: imageUrl ?? '',
      rating: rating ?? 0.0,
      city: city ?? '',
      address: address ?? '',
    );
  }
}
