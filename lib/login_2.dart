import 'package:flutter/material.dart';
import 'package:flutter_study/todolist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_study/riverpod.dart';

// 로그인 상태를 관리하는 클래스
class LoginState {
  final bool isLoggedIn; //이 값이 true면 사용자가 로그인한 상태이고, false면 로그인하지 않은 상태

  LoginState({required this.isLoggedIn});

  // 상태를 업데이트하기 위해 복사본을 만드는 메서드 (복사본 만드는 이유?불변성 유지, 상태 업데이트의 가독성, 유지보수성 향상)
  LoginState copyWith({bool? isLoggedIn}) {
    return LoginState(isLoggedIn: isLoggedIn ?? this.isLoggedIn);
    // ??는 null 병합 연산자로,isLoggedIn 값이 null이면 기존 값(this.isLoggedIn)을 유지하고, null이 아니면 새로운 값을 사용합니다.
    // 이 방법은 상태를 불변(immutable)으로 유지하면서, 필요한 속성만 업데이트할 수 있게 해줍니다.
  }
}

// LoginStateNotifier를 통해 상태를 관리
class LoginStateNotifier extends StateNotifier<LoginState> {
  //stateNotifier(=상태관리역할 클래스)<상태 관리할 타입>
  LoginStateNotifier()
      : super(LoginState(isLoggedIn: false)); //초기 상태를 isLoggedIn: false로 설정

  void loginSuccess() {
    state = state.copyWith(isLoggedIn: true);
  }

  void logout() {
    state = state.copyWith(isLoggedIn: false);
  }
}

// Riverpod provider 정의
final loginStateProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>(
  (ref) => LoginStateNotifier(),
);

//기존의 StatelessWidget 대신 Riverpod의 ConsumerWidget을 상속받아 사용합니다.
class Login2 extends ConsumerWidget {
  const Login2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //WidgetRef: 이 객체는 Riverpod의 상태에 접근하고, 상태를 읽거나 변경하는 기능을 제공합니다.

    // 로그인 상태를 감시
    final loginNotifier = ref.read(loginStateProvider.notifier);
    //ref.read를 사용해 loginStateProvider의 notifier에 접근합니다. 이는 상태를 변경할 수 있는 기능을 제공합니다.

    // 입력받는 id,password
    String inputId = "";
    String inputPassword = "";

    String id = "test";
    String password = "1234";
    // 변수 두 개씩 사용하는 이유는 사용자의 입력과 미리 정의된 값(정답)을 비교하여 인증을 수행하기 위해서

    bool errorId = false;
    bool errorPassword = false;

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
                  if (errorId) {
                    errorId = false; //errorId값이 true일 경우에 false로 바꿔줌
                  }
                },
                decoration: InputDecoration(
                    hintText: 'id', errorText: errorId ? '아이디가 맞지 않습니다' : null),
              ),
              TextField(
                onChanged: (value) {
                  inputPassword = value;
                  if (errorPassword) {
                    errorPassword = false;
                  }
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
                  errorId = inputId != id;
                  errorPassword = inputPassword != password;

                  if (!errorId && !errorPassword) {
                    // 로그인 성공 시 상태를 변경
                    loginNotifier.loginSuccess();

                    // 로그인 성공 시 페이지 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TodoApp(), // 페이지 이동
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
