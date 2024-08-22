import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basic_providers.g.dart';

/// This file contains a set of basic providers that can be used by others as
/// base providers for demo purposes.

@riverpod
Future<int> futureAsyncTwo(FutureAsyncTwoRef ref) async {
  return 2;
}

@riverpod
Future<int> futureSyncTwo(FutureSyncTwoRef ref) {
  return Future.value(2);
}

@riverpod
FutureOr<int> futureOrAsyncThree(FutureOrAsyncThreeRef ref) async {
  return 3;
}

@riverpod
FutureOr<int> futureOrFutureSyncThree(futureOrFutureSyncThreeRef ref) {
  return Future.value(3);
}

@riverpod
FutureOr<int> futureOrSyncThree(FutureOrSyncThreeRef ref) {
  return 3;
}

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
