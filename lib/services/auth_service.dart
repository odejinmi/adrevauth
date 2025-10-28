import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

import '../models/user_task.dart'; // Import the new models

class AuthService {
  AuthService._() {
    _checkInitialAuthState();
  }

  static final AuthService instance = AuthService._();

  final String baseUrl = "https://adrevapi.dev.5starcompany.com.ng/api";
  final _authStateController = BehaviorSubject<bool>();

  Stream<bool> get onAuthStateChanged => _authStateController.stream;
  String appId = "";

  void _checkInitialAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.clear();
    final token = prefs.getString('token');
    _authStateController.add(token != null && token.isNotEmpty);
    if (token != null) {
      mytask(); // Fetch tasks if the user is already logged in
    }

    // Automatically get the package name
    final packageInfo = await PackageInfo.fromPlatform();
    appId = packageInfo.packageName;
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    
    if (response.statusCode == 200) {
      final detail = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      print(detail);
      await prefs.setString('name', detail['user']['name']??'');
      await prefs.setString('username', detail['user']['username']);
      await prefs.setString('email', detail['user']['email']);
      await prefs.setString('token', detail['token']);
      _authStateController.add(true);
      mytask(); // Also fetch tasks on new login
      return true;
    } else {
      return false;
    }
  }
  
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _authStateController.add(false);
  }

  void dispose() {
    _authStateController.close();
  }

  Future<bool> signup(String email, String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final detail = json.decode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', detail['token']);
      _authStateController.add(true); 
      mytask(); // Also fetch tasks on new signup
      return true;
    } else {
      return false;
    }
  }

  Future<String?> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/forgot-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['token']; 
    } else {
      return null;
    }
  }

  Future<bool> verifyOtp(String email, String otp, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verify-reset-code'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'code': otp,
        'token': token,
      }),
    );
    return response.statusCode == 200;
  }

  Future<bool> resetPassword(String email, String otp, String password, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'otp': otp,
        'password': password,
        'token': token
      }),
    );
    return response.statusCode == 200;
  }

  Future<bool> enrolluser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return false;

    final response = await http.post(
      Uri.parse('$baseUrl/apps/enroll'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'package': appId,
      }),
    );

    if (response.statusCode == 201) {
      var data = json.decode(response.body);
      await prefs.setString('appId', data["data"]["app_id"].toString());
      return true;
    } 
    return false;
  }

  Future<bool> logging(String event, String highscore) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final appId = prefs.getString('appId');

    if (token == null) return false;

    final response = await http.post(
      Uri.parse('$baseUrl/apps/$appId/tasks/log'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        "event": event,
        "value": highscore
      }),
    );
    print("Logging");
    print(event);
    print(response.body);
    return response.statusCode == 200;
  }

  /// Fetches the list of tasks for the current user and app.
  /// Returns a list of [UserTask] on success, or an empty list on failure.
  Future<List<UserTask>> mytask() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final appId = prefs.getString('appId');

    if (token == null || appId == null) {
      return []; // Not logged in or enrolled, return empty list
    }
    final response = await http.get(
      Uri.parse('$baseUrl/apps/$appId/my-tasks'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Use the generated parsing function to safely decode the response
      return userTasksFromJson(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      prefs.clear();
      _authStateController.add(false);
      // Use the generated parsing function to safely decode the response
      return [];
    } else {
      return [];
    }
  }

  Future<Map<String,dynamic>> dashboard() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final appId = prefs.getString('appId');

    if (token == null || appId == null) {
      return {}; // Not logged in or enrolled, return empty list
    }
    final response = await http.get(
      Uri.parse('$baseUrl/apps/$appId/summary'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Use the generated parsing function to safely decode the response
      return jsonDecode(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 403) {
      prefs.clear();
      _authStateController.add(false);
      // Use the generated parsing function to safely decode the response
      return {};
    } else {
      return {};
    }
  }
}
