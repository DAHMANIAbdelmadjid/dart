import 'package:dartz/dartz.dart';
import 'package:tabibi_2/data/data_source/remote_data_source.dart';
import 'package:tabibi_2/data/network/error.dart';
import 'package:tabibi_2/data/response/response.dart';
import 'package:tabibi_2/domain/models/city.dart';
import 'package:tabibi_2/domain/models/doctor.dart';
import 'package:tabibi_2/domain/models/models.dart';
import 'package:tabibi_2/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Error, Login>> login(LoginResponse loginResponse) async {
    try {
      if (loginResponse.succeeded == true) {
        final login = Login(
          statusCode: loginResponse.statusCode ?? 0,
          succeeded: loginResponse.succeeded ?? false,
          message: loginResponse.message ?? '',
          error: loginResponse.error ?? '',
          token: loginResponse.token ?? '',
        );
        return Right(login);
      } else {
        return Left(Error(loginResponse.statusCode ?? 0,
            loginResponse.error ?? 'Unknown error'));
      }
    } catch (e) {
      return Left(Error(500, e.toString()));
    }
  }

  @override
  Future<Either<Error, List<City>>> getCities() async {
    try {
      final response = await _remoteDataSource.getCities();

      if (response.succeeded == true) {
        final cities = (response.data?.map((cityData) => cityData.toDomain()).toList() ??
                [])
            .cast<City>();
        return Right(cities);
      } else {
        return Left(
            Error(response.statusCode ?? 0, response.error ?? 'Unknown error'));
      }
    } catch (e) {
      return Left(Error(-1, e.toString()));
    }
  }

  @override
  Future<Either<Error, List<City>>> searchCities(String query) async {
    try {
      final response = await _remoteDataSource.searchCities(query);
      if (response.succeeded == true) {
        final cities = (response.data?.map((cityData) => cityData.toDomain()).toList() ??
                [])
            .cast<City>();
        return Right(cities);
      } else {
        return Left(
            Error(
              response.statusCode ?? 0
              , response.error ?? 'Unknown error'));
      }
    } catch (e) {
      return Left(Error(-1, e.toString()));
    }
  }

  @override
  Future<Either<Error, List<Doctor>>> getDoctors() async {
    try {
      final response = await _remoteDataSource.getDoctors();
      if (response.succeeded == true) {
        final doctors = (response.data
                ?.map((doctorData) => doctorData.toDomain())
                .toList() ??
            []) as List<Doctor>;
        return Right(doctors);
      } else {
        return Left(
            Error(response.statusCode ?? 0, response.error ?? 'Unknown error'));
      }
    } catch (e) {
      return Left(Error(-1, e.toString()));
    }
  }

  @override
  Future<Either<Error, List<Doctor>>> searchDoctors(
      String query, String city) async {
    try {
      final response = await _remoteDataSource.searchDoctors(query, city);
      if (response.succeeded == true) {
        final doctors = (response.data
                ?.map((doctorData) => doctorData.toDomain())
                .toList() ??
            [])
            .cast<Doctor>();
        return Right(doctors);
      } else {
        return Left(
            Error(response.statusCode ?? 0, response.error ?? 'Unknown error'));
      }
    } catch (e) {
      return Left(Error(-1, e.toString()));
    }
  }
}
