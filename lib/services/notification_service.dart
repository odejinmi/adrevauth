
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final String baseUrl = "https://adrevapi.dev.5starcompany.com.ng/api";

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<http.Response> getNotifications() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/notifications'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }

  Future<http.Response> getUnreadNotifications() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/notifications/unread'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }

  Future<http.Response> getNotificationCount() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/notifications/counts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }

  Future<http.Response> markAsRead(String notificationId) async {
    final token = await _getToken();
    final response = await http.patch(
      Uri.parse('$baseUrl/notifications/$notificationId/read'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }

  Future<http.Response> markAllAsRead() async {
    final token = await _getToken();
    final response = await http.patch(
      Uri.parse('$baseUrl/notifications/read-all'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    print(response.body);
    return response;
  }
}
