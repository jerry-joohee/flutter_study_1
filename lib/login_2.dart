import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_2.g.dart';

@riverpod
class helloWorld extends _$helloWorld {
  @override
  build() =>
      bool errorId = false; bool errorPassword = false;
  void method() {
    inputId = value;
    if (errorId) {
      errorId = false; //errorId값이 true일 경우에 false로 바꿔줌
    };
    inputPassword = value;
    if (errorPassword) {
      errorPassword = false;
    }
  }
}

class _LoginState extends State<Login> {
  //입력받는 id,password
  String inputId = "";
  String inputPassword = "";

  String id = "test";
  String password = "1234";
  //변수 두 개씩 사용하는 이유는 사용자의 입력과 미리 정의된 값(정답)을 비교하여 인증을 수행하기 위해서


class Study2 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool value = ref.watch(helloWorldProvider);
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
                  setState(() {
                    ref.read(helloWorldProvider.notifier).method();
                  }
                    // inputId = value;
                    // if (errorId) {
                    //   errorId = false; //errorId값이 true일 경우에 false로 바꿔줌
                    // }
                  });
                },
                decoration: InputDecoration(
                    hintText: 'id', errorText: errorId ? '아이디가 맞지 않습니다' : null),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
  ref.read(helloWorldProvider.notifier).method();
                    // inputPassword = value;
                    // if (errorPassword) {
                    //   errorPassword = false;
                    // }
                  });
                },
                decoration: InputDecoration(
                    hintText: 'password',
                    errorText: errorPassword ? '비밀번호가 맞지 않습니다' : null),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    errorId = inputId != id;
                    //errorId = inputId != id <- 비교연산자 / inputId와 id가 같지 않으면 true, 같으면 false 반환
                    errorPassword = inputPassword != password;

                    if (inputId == id && inputPassword == password) {
                      //'&&=AND'두 조건 모두 참일때 실행 역할 : inputID와 id값이 같고 inputPassword와 password가 같을때~
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoApp(), //페이지 이동
                        ),
                      );
                    }
                  });
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

