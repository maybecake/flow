import 'dart:async';

import 'package:flow_1/async/sync_watch.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'future.g.dart';

/// Returns a number after a delay.
@riverpod
Future<int> futureNumber(FutureNumberRef ref) {
  return Future.delayed(const Duration(seconds: 2), () => 1);
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

/// Doubler for watched future number.
@riverpod
FutureOr<int> watchedFutureDoubler(WatchedFutureDoublerRef ref) {
  final number = ref.autoDisposeFutureSyncWatch(futureNumberProvider);
  return number.then((v) => v * 2);
}

/// Tripler for watched future number.
@riverpod
FutureOr<int> watchedFutureTripler(WatchedFutureTriplerRef ref) {
  final number = ref.autoDisposeFutureSyncWatch(futureNumberProvider);
  return number.then((v) => v * 3);
}
