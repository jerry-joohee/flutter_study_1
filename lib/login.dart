import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 40),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'id'),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'password'),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.black),
                width: double.maxFinite,
                height: 52,
                child: Center(
                  child: Text(
                    'login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
