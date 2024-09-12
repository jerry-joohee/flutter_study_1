import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'loginProvider.g.dart';

@riverpod
class HelloWorld extends _$HelloWorld {
  @override
  build() => false;

  void method() {
    state = true;
  }
}
