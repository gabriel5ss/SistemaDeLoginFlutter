import 'package:flutter/material.dart';
import 'package:fluttle_laravel_api/models/user.dart';
import 'package:fluttle_laravel_api/net_tools/conn.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = '/sign_up';

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
   
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<User>? _futureUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Screen"),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: (_futureUser == null ? buildColumn() : buildFutureBuilder()),
      ),
    );
  }

  Form buildColumn(){
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your name',
                ),
                validator: (String? value) {
                  if(value == null || value.isEmpty){
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
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
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    _futureUser = ApiConn().createUser(_nameController.text,_emailController.text, _passwordController.text);
                  });
                },
                child: Text('Send'),
                ),
            ),
          ],
          ),
      );
  }

  FutureBuilder<User> buildFutureBuilder(){
    return FutureBuilder<User>(
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
}