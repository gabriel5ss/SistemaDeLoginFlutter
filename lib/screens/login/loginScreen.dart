import 'package:flutter/material.dart';
import 'package:fluttle_laravel_api/models/userLogin.dart';
import 'package:fluttle_laravel_api/net_tools/conn.dart';
import 'package:fluttle_laravel_api/screens/signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
   
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<UserLogin>? _futureUser;
  String token = '';

  @override
  void initState(){
    super.initState();
    checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (token == '' ? buildFormColumn() : buildFutureBuilder()),
        //child: checkUser(),
      ),
    );
  }

  Form buildFormColumn(){
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                ),
                validator: (String? value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Enter your password',
                ),
                obscureText: true,
                validator: (String? value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: TextButton(
                      onPressed: () =>_navigation(context),
                      child: Text('Create Account'),
                      ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          _futureUser = ApiConn().userLogin(_emailController.text, _passwordController.text);
                        });
                      },
                      child: Text('Login'),
                      ),
                  ),
                ],
              ),
            ),
          ],
          ),
      );
  }

  FutureBuilder<UserLogin> buildFutureBuilder(){
    return FutureBuilder<UserLogin>(
      future: _futureUser,
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Text(snapshot.data!.accessToken);
        } else if (snapshot.hasError){
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  void checkUser() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    //token = _prefs.getString('accessToken')!;
  }

  void _navigation(BuildContext context){
    Navigator.pushNamed(context, SignUpScreen.routeName);
  }
}