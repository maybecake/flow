import 'package:flow_1/async/streams.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test/test.dart';
import '../container.dart';

part 'stream_to_futureor_test.g.dart';

/// Demonstrate how to convert a Stream provider to a FutureOr provider.

@riverpod
Stream<int> simpleStream(SimpleStreamRef ref) async* {
  yield 1;
  await Future(() {});
  yield 2;
  await Future(() {});
  yield 3;
}

@riverpod
FutureOr<int> futureOrDoubler(FutureOrDoublerRef ref, String family) {
  final numbers = ref.watch(simpleStreamProvider);
  final hasResult = numbers.hasValue || numbers.hasValue;

  if (hasResult) {
    return numbers.requireValue * 2;
  } else {
    return ref.read(simpleStreamProvider.future).then((v) => v * 2);
  }
}

@riverpod
Future<int> futureDoubler(FutureDoublerRef ref, String family) {
  return ref.watch(simpleStreamProvider.future).then((v) => v * 2);
}

@riverpod
Stream<int> streamDoubler(StreamDoublerRef ref, String family) async* {
  yield* ref.watch(simpleStreamProvider.future).asStream().map((v) => v * 2);
}

void main() {
  late ProviderContainer container;
  setUp(() => container = createContainer());

  test('FutureOr can provide value with loading state.', () async {
    // Keep the underlying stream alive.
    container.listen(simpleStreamProvider, (_, __) {});

    expect(container.read(simpleStreamProvider).isLoading, isTrue);

    // Provider is loading because source is loading and data is not ready.
    expect(container.read(futureOrDoublerProvider('a')).isLoading, isTrue);

    await Future(() {});
    expect(container.read(simpleStreamProvider).isLoading, isFalse);
    expect(container.read(simpleStreamProvider).value, 1);

    // Provider can provide value because it is available. This instance of the
    // Provider is rebuilt since the source stream emitted a new value.
    expect(container.read(futureOrDoublerProvider('a')).isLoading, isFalse);
    expect(container.read(futureOrDoublerProvider('a')).value, 2);

    // Provider and initialize without going through loading state.
    expect(container.read(futureOrDoublerProvider('b')).isLoading, isFalse);
    expect(container.read(futureOrDoublerProvider('b')).value, 2);

    await Future(() {});
    expect(container.read(simpleStreamProvider).value, 2);

    expect(container.read(futureOrDoublerProvider('a')).value, 4);
    expect(container.read(futureOrDoublerProvider('b')).value, 4);
    expect(container.read(futureOrDoublerProvider('c')).value, 4);

    await Future(() {});
    expect(container.read(simpleStreamProvider).value, 3);

    expect(container.read(futureOrDoublerProvider('a')).value, 6);
  });

  test('Future initalizes in loading state.', () async {
    // Keep the underlying stream alive.
    container.listen(simpleStreamProvider, (_, __) {});

    expect(container.read(simpleStreamProvider).isLoading, isTrue);

    // Provider is loading because source is loading and data is not ready.
    expect(container.read(futureDoublerProvider('a')).isLoading, isTrue);

    await Future(() {});
    expect(container.read(simpleStreamProvider).isLoading, isFalse);
    expect(container.read(simpleStreamProvider).value, 1);

    // Provider is loading because it is rebuilt and initial state is loading.
    expect(container.read(futureDoublerProvider('a')).isLoading, isTrue);
    // This follow Provider is rebuilt and not same instance as above.
    expectLater(
        container.read(futureDoublerProvider('a').future), completion(2));

    await Future(() {});
    expect(container.read(simpleStreamProvider).value, 2);

    // Keep the future provider alive.
    container.listen(futureDoublerProvider('a'), (_, __) {});
    // Provider is loading because it is rebuilt and initial state is loading.
    expect(container.read(futureDoublerProvider('a')).isLoading, isTrue);
    expect(container.read(futureDoublerProvider('a')).value, null);

    await Future(() {});
    expect(container.read(simpleStreamProvider).value, 3);

    // Provider is still loading due to being rebuilt. But it retains the
    // previous value since the provider itself is kept alive.
    expect(container.read(futureDoublerProvider('a')).isLoading, isTrue);
    expect(container.read(futureDoublerProvider('a')).value, 4);
    expectLater(
        container.read(futureDoublerProvider('a').future), completion(6));
  });
}
