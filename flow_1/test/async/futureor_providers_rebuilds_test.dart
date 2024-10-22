import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test/test.dart';

import '../container.dart';

part 'futureor_providers_rebuilds_test.g.dart';

@riverpod
Stream<int> stream(StreamRef ref) async* {
  throw UnimplementedError();
}

int readHasResultsBuilds = 0;

@riverpod
FutureOr<int> readHasResults(ReadHasResultsRef ref) {
  ++readHasResultsBuilds;

  final hasResults =
      ref.read(streamProvider.select((v) => v.hasValue || v.hasError));
  if (hasResults) {
    return ref.watch(streamProvider).requireValue;
  }
  return ref.watch(streamProvider.future).then((v) => v);
}

int watchHasResultsBuilds = 0;
@riverpod
FutureOr<int> watchHasResults(WatchHasResultsRef ref) {
  ++watchHasResultsBuilds;
  final hasResults =
      ref.watch(streamProvider.select((v) => v.hasValue || v.hasError));
  if (hasResults) {
    return ref.watch(streamProvider).requireValue;
  }
  return ref.watch(streamProvider.future).then((v) => v);
}

void main() {
  late ProviderContainer container;
  late StreamController<int> streamController;

  setUp(() {
    readHasResultsBuilds = 0;
    watchHasResultsBuilds = 0;
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
    container.listen(readHasResultsProvider, (_, __) {});

    streamController.add(1);
    expect(container.read(readHasResultsProvider).isLoading, isTrue);
    expect(readHasResultsBuilds, 1);
    expect(container.read(watchHasResultsProvider).isLoading, isTrue);
    expect(watchHasResultsBuilds, 1);
    await Future(() {});

    expect(container.read(readHasResultsProvider).value, 1);
    expect(readHasResultsBuilds, 1);

    // Watch version has an additional rebuild when the streamProvider goes from
    // loading to value.
    expect(container.read(watchHasResultsProvider).value, 1);
    expect(watchHasResultsBuilds, 2);

    streamController.add(2);
    await Future(() {});

    expect(container.read(readHasResultsProvider).value, 2);
    expect(readHasResultsBuilds, 2);
    expect(container.read(watchHasResultsProvider).value, 2);
    expect(watchHasResultsBuilds, 3);

    streamController.add(3);
    await Future(() {});

    expect(container.read(readHasResultsProvider).value, 3);
    expect(readHasResultsBuilds, 3);
    expect(container.read(watchHasResultsProvider).value, 3);
    expect(watchHasResultsBuilds, 4);
  });
}
