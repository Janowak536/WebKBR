import 'dart:convert';
import 'package:flutter_2kbr/data/models/dtos/user_register_dto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ApiService {
  final String baseUrl = 'https://localhost:7027';

  Future<bool> isAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');

    if (jwt == null) {
      throw Exception('JWT token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/api/User/IsAdmin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      final boolValue = jsonDecode(response.body)['isAdmin'] as bool?;

      if (boolValue != null) {
        return boolValue;
      } else {
        print('Invalid value received for isAdmin: $boolValue');
        throw Exception('Invalid value received for isAdmin');
      }
    } else {
      throw Exception('Failed to get the user');
    }
  }

  Future<String> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/User/Login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', jsonDecode(response.body)['token']);
        Map<String, dynamic> json = jsonDecode(response.body);
        return json['token'];
      } else {
        throw Exception('Failed to login. Error: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error occurred while making the request.');
    }
  }

  Future<bool> register(UserRegisterDto registerData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/User/Register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registerData.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to register. Error: ${response.body}');
    }
  }

  Future<void> editClientDetails(
      int nip, String clientType, String discountCode) async {
    final String baseUrl = 'https://localhost:7027';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');
    if (jwt == null) {
      throw Exception('JWT token not found');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/api/User/EditClientDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode({
        'NIP': nip,
        'ClientType': clientType,
        'DiscountCode': discountCode,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to edit client details');
    }
  }

  Future<String> changePassword(
      String username, String oldPassword, String newPassword) async {
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
        'Username': username,
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
}
