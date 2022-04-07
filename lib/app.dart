import 'package:flutter/material.dart';
import 'package:fluttle_laravel_api/screens/login/loginScreen.dart';
import 'package:fluttle_laravel_api/screens/signup/signup.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name){
          case SignUpScreen.routeName:
            return MaterialPageRoute(builder: (context){
              return const SignUpScreen();
            });
        }
        return null;
      },
      home: const LoginScreen(),
    );
  }
}