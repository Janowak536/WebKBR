import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_2kbr/data/models/weather_forecast.dart';

class ApiService {
  final String baseUrl = 'https://localhost:7027';
  Future<List<WeatherForecast>> getWeatherForecast() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');

    if (jwt == null) {
      throw Exception('JWT token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/WeatherForecast'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<WeatherForecast> weatherForecasts =
          data.map((json) => WeatherForecast.fromJson(json)).toList();
      return weatherForecasts;
    } else {
      throw Exception('Failed to fetch weather forecast');
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/User/Login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'Email': email, 'Password': password}),
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', jsonDecode(response.body)['token']);
        return 'Logged in successfully';
      } else {
        throw Exception('Failed to log in');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error occurred while making the request.');
    }
  }

  Future<String> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/User/Register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'Email': email, 'Password': password}),
    );

    if (response.statusCode == 201) {
      return 'Registered successfully';
    } else {
      throw Exception('Failed to register');
    }
  }

  Future<String> changePassword(
      String email, String oldPassword, String newPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');

    if (jwt == null) {
      throw Exception('JWT token not found');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/User/ChangePassword'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode({
        'Email': email,
        'OldPassword': oldPassword,
        'NewPassword': newPassword
      }),
    );

    if (response.statusCode == 200) {
      return 'Password changed successfully';
    } else {
      throw Exception('Failed to change password');
    }
  }

  Future<String> getMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');

    if (jwt == null) {
      throw Exception('JWT token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/auth'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }
}
