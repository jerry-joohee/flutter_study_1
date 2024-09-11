import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_study/todolist.dart';

part 'logins.g.dart';

@riverpod
class HelloWorld extends _$HelloWorld {
  @override
  build() => false;

  void method() {
    state = true;
    print(state);
  }
}

class Study2 extends ConsumerStatefulWidget {
  const Study2({super.key});

  @override
  ConsumerState<Study2> createState() => _Study2State();
}

class _Study2State extends ConsumerState<Study2> {
  // 입력받는 id, password
  String inputId = "";
  String inputPassword = "";

  // 미리 정의된 id, password (정답)
  final String id = "test";
  final String password = "1234";

  bool errorId = false;
  bool errorPassword = false;

  @override
  Widget build(BuildContext context) {
    final helloWorld = ref.watch(helloWorldProvider); // Riverpod 상태 감시
    final helloWorldNotifier =
        ref.read(helloWorldProvider.notifier); // 상태 변경용 notifier

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 40),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    inputId = value;
                    if (errorId) {
                      errorId = false; // 오류가 있을 때 리셋
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'id',
                  errorText: errorId ? '아이디가 맞지 않습니다' : null,
                ),
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    inputPassword = value;
                    if (errorPassword) {
                      errorPassword = false;
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'password',
                  errorText: errorPassword ? '비밀번호가 맞지 않습니다' : null,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    errorId = inputId != id;
                    errorPassword = inputPassword != password;

                    if (!errorId && !errorPassword) {
                      // 로그인 성공 시 페이지 이동
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TodoApp(),
                        ),
                      );
                      // 상태 업데이트 메서드 호출
                      helloWorldNotifier.method();
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
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
