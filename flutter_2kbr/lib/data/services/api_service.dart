import 'dart:convert';
import 'package:flutter_2kbr/data/models/dtos/user_register_dto.dart';
import 'package:flutter_2kbr/data/models/order.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ApiService {
  final String baseUrl = 'https://localhost:7027';

  Future<bool> isAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');

    if (jwt == null) {
      throw Exception('JWT nie znaleziony');
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
        print('Nieprawidłowa wartość dla isAdmin: $boolValue');
        throw Exception('Nieprawidłowa wartość dla isAdmin');
      }
    } else {
      throw Exception('Błąd poczas pobierania użytkownika');
    }
  }

  Future<void> changePassword(
      String username, String oldPassword, String newPassword) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/User/ChangePassword'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'Username': username,
        'OldPassword': oldPassword,
        'NewPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Błąd podczas zmiany hasła');
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

        final clientId = jsonDecode(response.body)['clientId'];
        if (clientId != null) {
          await prefs.setInt('clientId', clientId);
        }

        Map<String, dynamic> json = jsonDecode(response.body);
        return json['token'];
      } else {
        throw Exception('Błąd podczas logowania ${response.body}');
      }
    } catch (e) {
      print('Błąd $e');
      throw Exception('Błąd podczas wykonywania zapytania');
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
      throw Exception('Błąd podczas rejestracji ${response.body}');
    }
  }

  Future<void> editClientDetails(
      int nip, String clientType, String discountCode) async {
    final String baseUrl = 'https://localhost:7027';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');
    if (jwt == null) {
      throw Exception('JWT token nieznaleziony');
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
      throw Exception('błąd podczas edycji szczegółów klienta');
    }
  }

  Future<int> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');
    if (jwt == null) {
      throw Exception('JWT token nieznaleziony');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/api/User/GetCurrentUser'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    if (response.statusCode == 200) {
      final intValue = jsonDecode(response.body)['userId'] as int?;

      if (intValue != null) {
        return intValue;
      } else {
        print('Błędna wartość $intValue');
        throw Exception('Błędna wartość dla userId');
      }
    } else {
      throw Exception('Błąd podczas pobierania użytkownika');
    }
  }

  Future<dynamic> getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');
    if (jwt == null) {
      throw Exception('JWT token nieznaleziony');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/api/Orders'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Bład podczas pobierania użytkownika');
    }
  }

  Future<dynamic> getOrderByClientId(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');
    if (jwt == null) {
      throw Exception('JWT token not found');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/api/Orders/client/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Bład podczas pobierania zamówień użytkownika');
    }
  }

  Future<dynamic> getOrderById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');
    if (jwt == null) {
      throw Exception('JWT token nieznaleziony');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/api/Orders/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Bład podczas pobierania zamówień użytkownika');
    }
  }

  Future<bool> sendJsonData(List<Order> orders) async {
    final clientId = await ApiService().getCurrentUser();
    if (orders.isEmpty) {
      return false;
    }
    final List<Map<String, dynamic>> transformedData = orders.map((order) {
      return {
        'clientID': clientId,
        'orderID': 0,
        'modelID': order.modelId,
        'colorID': order.colorId,
        'mdfID': order.mdfId,
        'width': order.width,
        'height': order.height,
      };
    }).toList();

    final jsonData = jsonEncode(transformedData);
    print(jsonData);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Orders'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print('Dane zostały wysłane pomyślnie.');
        return true;
      } else {
        print('Wystąpił błąd podczas wysyłania danych: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Wystąpił błąd podczas komunikacji z API: $e');
      return false;
    }
  }

  Future<double> calculateJsonData(List<Order> orders) async {
    final clientId = await getCurrentUser();
    final List<Map<String, dynamic>> transformedData = orders.map((order) {
      return {
        'clientID': clientId,
        'orderID': 0,
        'modelID': order.modelId,
        'colorID': order.colorId,
        'mdfID': order.mdfId,
        'width': order.width,
        'height': order.height,
      };
    }).toList();

    final jsonData = jsonEncode(transformedData);
    print(jsonData);

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/Orders/CalculateOrderValue'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(response.body);
        final double totalValue = jsonResult['totalValue'] ?? 0.0;
        print('Dane zostały wysłane pomyślnie. Total Value: $totalValue');
        return totalValue;
      } else {
        print('Wystąpił błąd podczas wysyłania danych: ${response.statusCode}');
        return 0.0;
      }
    } catch (e) {
      print('Wystąpił błąd podczas komunikacji z API: $e');
      return 0.0;
    }
  }

  Future<bool> updateOrderStatus(int orderId, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/Orders/status/$orderId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(status),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteOrderItem(int productId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/Orders/item/$productId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteOrder(int orderId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/Orders/$orderId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response.statusCode == 200;
  }

  Future<dynamic> getOrderStatusAndValue(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');
    if (jwt == null) {
      throw Exception('JWT token nieznaleziony');
    }
    final response = await http.get(
      Uri.parse('$baseUrl/api/Orders/status/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Bład podczas pobierania zamówień użytkownika');
    }
  }
}
