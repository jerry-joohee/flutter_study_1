import 'package:flutter/material.dart';

class Todo {
  String title; //타이틀
  String description; //설명

  Todo({required this.title, required this.description});
}

class todoApp extends StatefulWidget {
  //todoApp 클래스: StatefulWidget을 상속받아 상태를 가질 수 있는 위젯
  const todoApp({Key? key}) : super(key: key);

  @override
  State<todoApp> createState() => _todoApp();
//createState 메서드: _todoApp 상태 객체를 반환
}

class _todoApp extends State<todoApp> {
  //_todoApp 클래스: todoApp의 상태를 정의하는 클래스
  String title = "";
  String description = "";
  //title과 description 변수: 사용자가 입력한 제목과 설명을 저장

  List<Todo> todos = []; //todos 리스트: 할 일 항목을 저장하는 리스트

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Todo List",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            //+아이콘
            onPressed: () {
              showDialog(
                //팝업
                barrierColor: Colors.black.withAlpha(100),
                //딤
                context: context,
                builder: (_) {
                  //builder : 다이얼로그의 UI를 정의하는 함수
                  return AlertDialog(
                    //AlertDialog: 다이얼로그의 UI를 정의하는 위젯
                    title: const Text('나의 할일'),
                    actions: [
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            title = value;
                            //onChanged: 입력된 텍스트가 변경될 때 호출되는 콜백 함수. 입력된 값을 title 변수에 저장합
                          });
                        },
                        decoration: InputDecoration(hintText: "글 제목"),
                      ),
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            description = value;
                            //할 일의 내용을 입력받는 필드. 입력된 값을 description 변수에 저장
                          });
                        },
                        decoration: InputDecoration(hintText: "글 내용"),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ElevatedButton(
                          //ElevatedButton: 누를 수 있는 버튼 위젯
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              todos.add(
                                  Todo(title: title, description: description));
                            });
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
          )
        ],
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          //itemBuilder: 각 항목을 어떻게 렌더링할지 정의하는 함수. 여기서는 ListTile을 반환
          return ListTile(
            title: Text(todos[index].title),
            subtitle: Text(todos[index].description),
            onTap: () {
              //수정팝업
              title = todos[index].title;
              description = todos[index].description;
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
                            hintText: todos[index].title,
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            description = value;
                          },
                          decoration: InputDecoration(
                            hintText: todos[index].description,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  todos[index].title = title;
                                  todos[index].description = description;
                                });
                              },
                              child: Text('수정하기')),
                        )
                      ],
                    );
                  });
            },
            trailing: IconButton(
              //trailing: 항목의 끝부분에 표시될 위젯
              onPressed: () {
                setState(() {
                  todos.removeAt(index);
                });
              },
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          );
        },
        itemCount: todos.length,
      ),
    );
  }
}
