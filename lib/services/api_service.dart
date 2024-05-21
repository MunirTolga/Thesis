import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_drive/models/user.dart';

class ApiService {
  static const String baseUrl = 'https://eu-central-1.aws.data.mongodb-api.com/app/data-ksmngye/endpoint/data/v1';

  Future<void> registerUser(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Collections'), // Kayıt endpoint'i
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()), // Kullanıcı bilgilerini JSON formatına dönüştür
    );

    if (response.statusCode == 201) {
      print('User registered successfully');
    } else {
      throw Exception('Failed to register user');
    }
  }

  // Tüm kullanıcıların email'lerini çeken işlev
  static Future<List<String>> getAllUserEmails() async {
    final response = await http.get(
      Uri.parse('$baseUrl/Collections'), // Kullanıcılar endpoint'i
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<String> emails = data.map((user) => user['email'] as String).toList();
      return emails;
    } else {
      throw Exception('Failed to load user emails');
    }
  }

  // Verilen bir email'e göre kullanıcının password'ünü çeken işlev
  static Future<String> getUserPasswordByEmail(String email) async {
    final response = await http.get(
      Uri.parse('$baseUrl/Collections/Users?email=$email'), // Kullanıcılar endpoint'i
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return data[0]['password'] as String;
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('Failed to load user password');
    }
  }
}
