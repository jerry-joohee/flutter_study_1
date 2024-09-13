import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'loginProvider.g.dart';

@riverpod
class HelloWorld extends _$HelloWorld {
  @override
  build() => false;

  //로그인 페이지
  void login() {
    state = true;
  }

  //투두리스트 페이지
  void logout() {
    state = false;
  }
}
