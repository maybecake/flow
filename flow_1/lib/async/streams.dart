import 'package:flow_1/helpers/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'streams.g.dart';

/// Number of times [simpleNumbersProvider] is built.
int simpleNumbersBuilds = 0;

/// Simple numbers tries to yield 1, 2, 3 in a [ProviderStream].
@riverpod
Stream<int> simpleNumbers(SimpleNumbersRef ref) async* {
  const color = ConsoleColors.green;
  printColor('  ^ simpleNumbers ${++simpleNumbersBuilds}', color);
  ref.onDispose(() {
    printColor('  🫠 simpleNumbers $simpleNumbersBuilds', color);
  });

  printColor('  < ($simpleNumbersBuilds) yield 1', color);
  yield 1;
  await Future.delayed(const Duration(seconds: 1), () {});
  printColor('  < ($simpleNumbersBuilds) yield 2', color);
  yield 2;
  await Future.delayed(const Duration(seconds: 1), () {});
  printColor('  < ($simpleNumbersBuilds) yield 3', color);
  yield 3;
}

/// Number of times [streamDoublerProvider] is built.
int streamDoublerBuilds = 0;

/// This stream doubler demo does not work if used by itself. I think it stop watching
/// after yielding and causes the simpleNumberProvider to be disposed and
/// rebuilt.
@riverpod
Stream<int> streamDoubler(StreamDoublerRef ref) async* {
  const color = ConsoleColors.red;
  printColor(' ^ streamDoubler(${++streamDoublerBuilds})', color);
  ref.onDispose(() {
    printColor(' 🫠 streamDoubler($streamDoublerBuilds)', color);
  });

  final number = await ref.watch(simpleNumbersProvider.future);
  printColor('  > streamDoubler($streamDoublerBuilds) > $number', color);
  yield number * 2;
}

class StreamDoublerDemo extends ConsumerWidget {
  const StreamDoublerDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(streamDoublerProvider).when(
          data: (data) => data.toString(),
          error: (e, st) => '$e, $st',
          loading: () => 'loading...',
        );

    return Text('Stream doubler demo: $value');
  }
}

/// Number of times [futureDoublerProvider] is built.
int futureDoublerBuilds = 0;

/// This works and does not cause the [simpleNumbersProvider] from disposing.
/// Having this at the same time as the [streamDoublerProvider] will cause that
/// to also work properly.
@riverpod
Future<int> futureDoubler(FutureDoublerRef ref) async {
  const color = ConsoleColors.yellow;
  printColor(' ^ futureDoubler(${++futureDoublerBuilds})', color);
  ref.onDispose(() {
    printColor(' 🫠 futureDoubler($futureDoublerBuilds)', color);
  });

  final number = await ref.watch(simpleNumbersProvider.future);
  printColor('  > futureDoubler($futureDoublerBuilds) > $number', color);
  return number * 2;
}

class FutureDoublerDemo extends ConsumerWidget {
  const FutureDoublerDemo({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(futureDoublerProvider).when(
          data: (data) => data.toString(),
          error: (e, st) => '$e, $st',
          loading: () => 'loading...',
        );

    return Text('Future doubler demo: $value');
  }
}
