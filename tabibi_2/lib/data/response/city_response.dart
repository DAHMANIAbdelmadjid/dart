import 'package:json_annotation/json_annotation.dart';
import 'package:tabibi_2/domain/models/city.dart';

part 'city_response.g.dart';

@JsonSerializable()
class CityResponse {
  @JsonKey(name: 'statusCode')
  int? statusCode;
  @JsonKey(name: 'succeeded')
  bool? succeeded;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'data')
  List<CityData>? data;

  CityResponse({
    this.statusCode,
    this.succeeded,
    this.message,
    this.error,
    this.data,
  });

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CityResponseToJson(this);
}

@JsonSerializable()
class CityData {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'country')
  String? country;

  CityData({
    this.id,
    this.name,
    this.country,
  });

  factory CityData.fromJson(Map<String, dynamic> json) =>
      _$CityDataFromJson(json);
  Map<String, dynamic> toJson() => _$CityDataToJson(this);

  City toDomain() {
    return City(
      id: id ?? 0,
      name: name ?? '',
      country: country ?? '',
    );
  }
}
