import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:tabibi_2/data/network/error.dart';
import 'package:tabibi_2/data/response/response.dart';
import 'package:tabibi_2/domain/models/city.dart';
import 'package:tabibi_2/domain/models/doctor.dart';
import 'package:tabibi_2/domain/models/models.dart';

abstract class Repository {
  Future<Either<Error, Login>> login(LoginResponse loginResponse);

  // City methods
  Future<Either<Error, List<City>>> getCities();
  Future<Either<Error, List<City>>> searchCities(String query);

  // Doctor methods
  Future<Either<Error, List<Doctor>>> getDoctors();
  Future<Either<Error, List<Doctor>>> searchDoctors(String query, String city);
}
