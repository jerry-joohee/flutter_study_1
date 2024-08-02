import 'package:flutter/material.dart';
import 'package:flutter_study/todolist.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //입력받는 id,password
  String inputId = "";
  String inputPassword = "";

  String id = "test";
  String password = "1234";
  //변수 두 개씩 사용하는 이유는 사용자의 입력과 미리 정의된 값(정답)을 비교하여 인증을 수행하기 위해서

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
                onChanged: (value) {
                  inputId = value;
                },
                decoration: InputDecoration(hintText: 'id'),
              ),
              TextField(
                onChanged: (value) {
                  inputPassword = value;
                },
                decoration:
                    InputDecoration(hintText: 'password',
                        errorText: if (inputId != id) {
              },),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (inputId == id && inputPassword == password) {
                    //'&&=AND'두 조건 모두 참일때 실행 역할
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoApp(), //페이지 이동
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'login',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
