import 'package:flutter_2kbr/data/services/api_service.dart';

import '../models/weather_forecast.dart';

class WeatherRepository {
  final ApiService _apiService;

  WeatherRepository({required ApiService apiService})
      : _apiService = apiService;

  Future<List<WeatherForecast>> getWeatherForecast() async {
    return _apiService.getWeatherForecast();
  }
}
