import 'package:tabibi_2/data/network/app_api.dart';
import 'package:tabibi_2/data/network/requests.dart';
import 'package:tabibi_2/data/response/response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<LoginResponse> signup(
      String fullName, String email, String password, String phoneNumber);
  Future<CitiesResponse> getCities();
  Future<CitiesResponse> searchCities(String query);
  Future<DoctorsResponse> getDoctors();
  Future<DoctorsResponse> searchDoctors(String query, String city);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppApi _appApi;
  RemoteDataSourceImpl(this._appApi);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _appApi.login(
        loginRequest.emailOrUserName, loginRequest.password);
  }

  @override
  Future<LoginResponse> signup(String fullName, String email, String password,
      String phoneNumber) async {
    return await _appApi.signup(fullName, email, password, phoneNumber);
  }

  @override
  Future<CitiesResponse> getCities() async {
    return await _appApi.getCities();
  }

  @override
  Future<CitiesResponse> searchCities(String query) async {
    return await _appApi.searchCities(query);
  }

  @override
  Future<DoctorsResponse> getDoctors() async {
    return await _appApi.getDoctors();
  }

  @override
  Future<DoctorsResponse> searchDoctors(String query, String city) async {
    return await _appApi.searchDoctors(query, city);
  }
}
