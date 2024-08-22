import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test/test.dart';

import '../container.dart';

part 'basic_future_providers_test.g.dart';

@riverpod
Future<int> futureAsyncOne(FutureAsyncOneRef ref) async {
  return 1;
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
FutureOr<int> futureOrFutureSyncFour(FutureOrFutureSyncFourRef ref) {
  return Future.value(4);
}

@riverpod
FutureOr<int> futureOrSyncFive(FutureOrSyncFiveRef ref) {
  return 5;
}

void main() {
  late ProviderContainer container;
  setUp(() => container = createContainer());

  test('Future providers initialize in loading state.', () {
    expect(container.read(futureAsyncOneProvider).isLoading, isTrue);
    expectLater(container.read(futureAsyncOneProvider.future), completion(1));

    expect(container.read(futureSyncTwoProvider).isLoading, isTrue);
    expectLater(container.read(futureSyncTwoProvider.future), completion(2));
  });

  test('Async FutureOr providers initialize in loading state.', () {
    expect(container.read(futureOrAsyncThreeProvider).isLoading, isTrue);
    expectLater(
        container.read(futureOrAsyncThreeProvider.future), completion(3));

    expect(container.read(futureOrFutureSyncFourProvider).isLoading, isTrue);
    expectLater(
        container.read(futureOrFutureSyncFourProvider.future), completion(4));
  });

  test('Sync FutureOr providers initialize in data state.', () {
    expect(container.read(futureOrSyncFiveProvider).isLoading, isFalse);
    expect(container.read(futureOrSyncFiveProvider).value, 5);
  });
}
