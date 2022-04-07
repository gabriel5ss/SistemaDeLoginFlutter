import 'package:fluttle_laravel_api/models/user.dart';

class UserLogin{
  final String accessToken;

  UserLogin({required this.accessToken});

  factory UserLogin.fromJson(Map<String, dynamic> json){
    return UserLogin(
      accessToken: json['access_token']
    );
  }
}