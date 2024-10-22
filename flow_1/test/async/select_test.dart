import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test/test.dart';

import '../container.dart';

part 'select_test.g.dart';

@riverpod
Stream<List<int>> stream(StreamRef ref) async* {
  throw UnimplementedError();
}

int evensBuilds = 0;

@riverpod
Future<List<int>> evens(EvensRef ref) async {
  evensBuilds++;
  return ref.watch(
      streamProvider.selectAsync((l) => l.where((i) => i % 2 == 0).toList()));
}

void main() {
  late ProviderContainer container;
  late StreamController<List<int>> streamController;

  setUp(() {
    evensBuilds = 0;
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

  test('Number of rebuilds with list selector, async selector, etc.', () async {
    final updates = <List<int>?>[];
    container.listen(evensProvider, (_, v) {
      updates.add(v.value);
    });

    streamController.add([1, 2, 3, 4, 5]);
    await Future(() {});
    expect(container.read(evensProvider).value, [2, 4]);
    expect(evensBuilds, 1);
    expect(container.read(evensProvider).value, [2, 4]);
    expect(evensBuilds, 1);
    expect(container.read(evensProvider).value, [2, 4]);
    expect(evensBuilds, 1);

    streamController.add([1, 2, 3, 4, 5, 7, 9, 10]);
    await Future(() {});
    expect(container.read(evensProvider).value, [2, 4]);

    streamController.add([1, 2, 3, 4, 5, 7, 9, 10]);
    await Future(() {});
    expect(container.read(evensProvider).value, [2, 4, 10]);

    streamController.add([1, 2, 3]);
    await Future(() {});
    expect(container.read(evensProvider).value, [2, 4, 10]);
    await Future(() {});
    await Future(() {});

    expect(evensBuilds, 4); // build counts don't make sense...

    // WTF, doesn't make any sense.
    expect(updates, [
      [2, 4],
      [2, 4],
      [2, 4, 10],
      [2, 4, 10],
      [2, 4, 10],
      [2, 4, 10],
      [2]
    ]);
  });
}
