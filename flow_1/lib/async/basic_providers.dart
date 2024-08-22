import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_providers.g.dart';

/// A notifier that returns a future that can be completed by calling [finish].
@riverpod
class FutureNumberNotifier extends _$FutureNumberNotifier {
  late Completer<int> _completer;

  @override
  Future<int> build() {
    _completer = Completer();
    return _completer.future;
  }

  void finish(int num) {
    _completer.complete(num);
  }
}
