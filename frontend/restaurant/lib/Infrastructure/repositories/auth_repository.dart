import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/user.dart';

class AuthRepository {
  final String baseUrl;

  AuthRepository({required this.baseUrl});

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    Map<String, dynamic> returned = json.decode(response.body);
    if (returned['success'] == true) {
      return User.fromJson(returned['user']);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<User> register(String username, String password, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'username': username, 'password': password, 'phone': phone}),
    );

    Map<String, dynamic> returned = json.decode(response.body);
    if (returned['success'] == true) {
      return User.fromJson(returned['user']);
    } else {
      throw Exception('Failed to register');
    }
  }
}
