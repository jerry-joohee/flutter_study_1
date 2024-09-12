import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_study/provider/loginProvider.dart';
import 'package:flutter_study/logins.dart';

class TodoApp extends ConsumerStatefulWidget {
  // TodoApp 클래스: StatefulWidget을 상속받아 상태를 가질 수 있는 위젯
  const TodoApp({Key? key}) : super(key: key);

  @override
  ConsumerState<TodoApp> createState() => _TodoAppState();
// createState 메서드: _TodoAppState 상태 객체를 반환
}

class Todo {
  String title; // 타이틀
  String description; // 설명
  bool isChecked; // 체크 상태

  Todo(
      {required this.title, required this.description, this.isChecked = false});
}

class _TodoAppState extends ConsumerState<TodoApp> {
  // _TodoAppState 클래스: TodoApp의 상태를 정의하는 클래스
  String title = "";
  String description = "";
  // title과 description 변수: 사용자가 입력한 제목과 설명을 저장

  List<Todo> todos = []; // todos 리스트: 할 일 항목을 저장하는 리스트
  String filter = "All"; // 필터링 상태

  @override
  Widget build(BuildContext context) {
    final todolist = ref.watch(helloWorldProvider);
    final todolistNotifier = ref.read(helloWorldProvider.notifier);
    //필터링 상태에 따른 할 일 항목 필터링
    List<Todo> filteredTodos;
// filteredTodos List : 현재 필터링 상태에 따라 todos List 에서 필터링된 항목을 저장
    if (filter == "All") {
      filteredTodos = todos;
    } else if (filter == "Checked") {
      filteredTodos = todos.where(
        (todo) {
          return todo.isChecked;
        },
      ).toList();
      // where : list타입 필터링 메소드
    } else {
      filteredTodos = todos.where(
        (todo) {
          return !todo.isChecked;
        },
      ).toList();
    }

    /* todos는 Todo 객체들의 리스트입니다.
    todo라는 이름은 그냥 변수 이름입니다. 이 변수는 todos 리스트 안의 각 할 일 항목을 가리킵니다.
    예를 들어, todos 리스트가 3개의 할 일 항목을 가지고 있다면, todo는 이 항목들을 하나씩 가리키며 isChecked 값을 검사합니다.
    todo는 그냥 우리가 정한 이름입니다. 이 이름은 아무거나 정할 수 있지만, 소문자로 시작하는 것이 일반적입니다.
    where 메서드는 리스트에서 특정 조건을 만족하는 항목들만 필터링하는 기능을 합니다.
    이 경우, where 메서드 안에 주어진 조건은 (todo) => todo.isChecked 입니다.
    (todo) => todo.isChecked는 람다 함수(익명 함수)로, 각 todo 객체의 isChecked 속성이 true인지를 확인합니다.
    따라서, todos.where((todo) => todo.isChecked)는 todos 리스트에서 isChecked 속성이 true인 항목들만 필터링하여 반환합니다.
    .toList() 메서드를 사용하여 이 Iterable을 List<Todo> 타입으로 변환합니다. */

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Todo List",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                // 팝업
                barrierColor: Colors.black.withAlpha(100),
                // 딤
                context: context,
                builder: (_) {
                  // builder: 다이얼로그의 UI를 정의하는 함수
                  return AlertDialog(
                    // AlertDialog: 다이얼로그의 UI를 정의하는 위젯
                    title: const Text('나의 할일'),
                    actions: [
                      TextField(
                        onChanged: (value) {
                          setState(
                            () {
                              title = value;
                              // onChanged: 입력된 텍스트가 변경될 때 호출되는 콜백 함수. 입력된 값을 title 변수에 저장합
                            },
                          );
                        },
                        decoration: InputDecoration(hintText: "글 제목"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(
                            () {
                              description = value;
                              // 할 일의 내용을 입력받는 필드. 입력된 값을 description 변수에 저장
                            },
                          );
                        },
                        decoration: InputDecoration(hintText: "글 내용"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ElevatedButton(
                          // ElevatedButton: 누를 수 있는 버튼 위젯
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(
                              () {
                                todos.add(Todo(
                                    title: title, description: description));
                              },
                            );
                          },
                          child: Text('추가하기'),
                        ),
                      )
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            //필터 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        filter = "All";
                      },
                    );
                  },
                  child: Text("All"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        filter = "Checked";
                      },
                    );
                  },
                  child: Text("Checked"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        filter = "Unchecked";
                      },
                    );
                  },
                  child: Text("Unchecked"),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTodos.length,
                //itemCount: filteredTodos.length로 필터링된 할 일 항목의 개수를 설정
                itemBuilder: (_, index) {
                  //itemBuilder : filteredTodos 리스트의 각 항목을 ListTile로 반환
                  return ListTile(
                    title: Text(filteredTodos[index].title),
                    //index: 현재 항목의 인덱스입니다. filteredTodos[index]: 필터링된 할 일 목록에서 현재 항목을 가져옵니다.filteredTodos[index].title: 현재 항목의 제목입니다.
                    subtitle: Text(filteredTodos[index].description),
                    trailing: Row(
                      // trailing: 항목의 끝부분에 표시될 위젯
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(
                              () {
                                title = filteredTodos[index].title;
                                description = filteredTodos[index].description;
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: Text('수정하기'),
                                      actions: [
                                        TextField(
                                          onChanged: (value) {
                                            title = value;
                                          },
                                          decoration: InputDecoration(
                                            hintText:
                                                filteredTodos[index].title,
                                          ),
                                        ),
                                        TextField(
                                          onChanged: (value) {
                                            description = value;
                                          },
                                          decoration: InputDecoration(
                                            hintText: filteredTodos[index]
                                                .description,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              // Navigator.of(context).pop() 다이얼로그 닫음
                                              setState(
                                                () {
                                                  filteredTodos[index].title =
                                                      title;
                                                  filteredTodos[index]
                                                          .description =
                                                      description;
                                                },
                                              );
                                            },
                                            child: Text('수정하기'),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(
                              () {
                                todos.removeAt(
                                    todos.indexOf(filteredTodos[index]));
                              },
                            );
                          },
                          icon: Icon(Icons.delete, color: Colors.red),
                        ),
                        IconButton(
                          // 체크박스 버튼
                          onPressed: () {
                            setState(
                              () {
                                filteredTodos[index].isChecked =
                                    !filteredTodos[index].isChecked;
                              },
                            );
                          },
                          icon: Icon(filteredTodos[index].isChecked
                              ? Icons.check_box
                              : Icons.check_box_outline_blank),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
                backgroundColor: Colors.grey,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Logins(),
                  ),
                );
                todolistNotifier.logout();
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
