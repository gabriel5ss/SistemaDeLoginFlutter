import 'dart:convert';
import 'package:fluttle_laravel_api/models/prefs.dart';
import 'package:fluttle_laravel_api/models/user.dart';
import 'package:fluttle_laravel_api/models/userLogin.dart';
import 'package:http/http.dart' as http;

class ApiConn {
  
  Future<User> createUser(String name, String email, String password) async {
    
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password
      }),
    );

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Create User');
    }
  }

  Future<UserLogin> userLogin(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password
      }),
    );

    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200){
      UserLogin user = UserLogin.fromJson(jsonDecode(response.body));
      userPrefs(user.accessToken);
      return user;
    } else {
      throw Exception('Failed to Create User');
    }
  }
}