import 'package:flutter/material.dart';
import 'package:tabibi_2/domain/models/city.dart';
import 'package:tabibi_2/domain/models/doctor.dart';
import 'package:tabibi_2/domain/repository/repository.dart';

enum DataStatus { initial, loading, success, error }

class CityDoctorProvider extends ChangeNotifier {
  final Repository _repository;

  CityDoctorProvider(this._repository);

  // Cities
  List<City> _cities = [];
  List<City> get cities => _cities;

  List<City> _filteredCities = [];
  List<City> get filteredCities => _filteredCities;

  DataStatus _citiesStatus = DataStatus.initial;
  DataStatus get citiesStatus => _citiesStatus;

  String _cityError = '';
  String get cityError => _cityError;

  // Doctors
  List<Doctor> _doctors = [];
  List<Doctor> get doctors => _doctors;

  List<Doctor> _filteredDoctors = [];
  List<Doctor> get filteredDoctors => _filteredDoctors;

  DataStatus _doctorsStatus = DataStatus.initial;
  DataStatus get doctorsStatus => _doctorsStatus;

  String _doctorError = '';
  String get doctorError => _doctorError;

  // Selected city
  City? _selectedCity;
  City? get selectedCity => _selectedCity;

  void setSelectedCity(City city) {
    _selectedCity = city;
    notifyListeners();
  }

  // Fetch all cities
  Future<void> fetchCities() async {
    _citiesStatus = DataStatus.loading;
    notifyListeners();

    final result = await _repository.getCities();
    result.fold(
      (error) {
        _citiesStatus = DataStatus.error;
        _cityError = error.toString();
      },
      (cities) {
        _cities = cities;
        _filteredCities = cities;
        _citiesStatus = DataStatus.success;
      },
    );

    notifyListeners();
  }

  // Search cities
  Future<void> searchCities(String query) async {
    if (query.isEmpty) {
      _filteredCities = _cities;
      notifyListeners();
      return;
    }

    _citiesStatus = DataStatus.loading;
    notifyListeners();

    final result = await _repository.searchCities(query);
    result.fold(
      (error) {
        _citiesStatus = DataStatus.error;
        _cityError = error.toString();
      },
      (cities) {
        _filteredCities = cities;
        _citiesStatus = DataStatus.success;
      },
    );

    notifyListeners();
  }

  // Fetch all doctors
  Future<void> fetchDoctors() async {
    _doctorsStatus = DataStatus.loading;
    notifyListeners();

    final result = await _repository.getDoctors();
    result.fold(
      (error) {
        _doctorsStatus = DataStatus.error;
        _doctorError = error.toString();
      },
      (doctors) {
        _doctors = doctors;
        _filteredDoctors = doctors;
        _doctorsStatus = DataStatus.success;
      },
    );

    notifyListeners();
  }

  // Search doctors
  Future<void> searchDoctors(String query) async {
    if (query.isEmpty && _selectedCity == null) {
      _filteredDoctors = _doctors;
      notifyListeners();
      return;
    }

    _doctorsStatus = DataStatus.loading;
    notifyListeners();

    final result = await _repository.searchDoctors(
      query,
      _selectedCity?.name ?? '',
    );

    result.fold(
      (error) {
        _doctorsStatus = DataStatus.error;
        _doctorError = error.toString();
      },
      (doctors) {
        _filteredDoctors = doctors;
        _doctorsStatus = DataStatus.success;
      },
    );

    notifyListeners();
  }

  // Filter doctors by city locally
  void filterDoctorsByCity(String cityName) {
    if (cityName.isEmpty) {
      _filteredDoctors = _doctors;
    } else {
      _filteredDoctors = _doctors
          .where(
              (doctor) => doctor.city.toLowerCase() == cityName.toLowerCase())
          .toList();
    }
    notifyListeners();
  }

  // Reset filters
  void resetFilters() {
    _filteredCities = _cities;
    _filteredDoctors = _doctors;
    _selectedCity = null;
    notifyListeners();
  }
}
