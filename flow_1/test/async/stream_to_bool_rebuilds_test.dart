import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test/test.dart';

import '../container.dart';

part 'stream_to_bool_rebuilds_test.g.dart';

@riverpod
Stream<int> stream(StreamRef ref) async* {
  throw UnimplementedError();
}

int isEvenBuilds = 0;

@riverpod
bool isEven(IsEvenRef ref) {
  ++isEvenBuilds;

  final number = ref.watch(streamProvider).valueOrNull;
  if (number != null) {
    return number.isEven;
  }
  return false;
}

int finalResultBuilds = 0;

@riverpod
bool finalResult(FinalResultRef ref) {
  finalResultBuilds++;
  return ref.watch(isEvenProvider);
}

void main() {
  late ProviderContainer container;
  late StreamController<int> streamController;

  setUp(() {
    isEvenBuilds = 0;
    finalResultBuilds = 0;
    streamController = StreamController.broadcast();

    container = createContainer(
      overrides: [
        streamProvider.overrideWith(
          (_) async* {
            yield* streamController.stream;
          },
        ),
      ],
    );

    // Keep alive.
    container.listen(streamProvider, (_, __) {});
  });

  test('Number of rebuilds', () async {
    container.listen(finalResultProvider, (_, __) {});

    streamController.add(1);
    expect(container.read(isEvenProvider), isFalse);
    expect(container.read(finalResultProvider), isFalse);
    expect(isEvenBuilds, 1);

    await Future(() {});

    expect(container.read(isEvenProvider), isFalse);
    expect(isEvenBuilds, 2);

    // isEvenProvider is rebuilt each time stream emits a new value.
    streamController.add(3);
    await Future(() {});

    expect(container.read(isEvenProvider), isFalse);
    expect(isEvenBuilds, 3);
    expect(container.read(finalResultProvider), isFalse);
    expect(finalResultBuilds, 1);

    streamController.add(5);
    await Future(() {});

    expect(container.read(isEvenProvider), isFalse);
    expect(isEvenBuilds, 4);
    expect(container.read(finalResultProvider), isFalse);
    expect(finalResultBuilds, 1);

    streamController.add(2);
    expect(container.read(finalResultProvider), isFalse);
    expect(finalResultBuilds, 1);
    await Future(() {});

    // finalResultProvider is rebuilt each time isEvenProvider changes.
    expect(container.read(finalResultProvider), isTrue);
    expect(finalResultBuilds, 2);
  });
}
