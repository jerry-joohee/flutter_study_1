import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study.g.dart';

@riverpod
class helloWorld extends _$helloWorld {
  @override
  String build() => 'hello world';
  void increment() {
    state = 'ss';
  }
}
// String helloWorld(HelloWorldRef ref) {
//   return 'Hello world';
// }

class Study extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(helloWorldProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('riverpod study'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => ref.read(helloWorldProvider.notifier).increment(),
            child: Text('${ref.watch(helloWorldProvider)}'),
          ),
        ),
      ),
    );
  }
}
