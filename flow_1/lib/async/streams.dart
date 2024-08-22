import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../helpers/debug.dart';
import '../helpers/strings.dart';

part 'streams.g.dart';

/// Number of times [simpleNumbersProvider] is built.
int simpleNumbersBuilds = 0;

/// Simple numbers tries to yield 1, 2, 3 in a [ProviderStream].
@Riverpod(keepAlive: false)
Stream<int> simpleNumbers(SimpleNumbersRef ref) async* {
  const color = ConsoleColors.green;
  addDebug('simpleNumbers', ++simpleNumbersBuilds, color, ref.onDispose);

  printColor('  < ($simpleNumbersBuilds) waiting for 1st', color);
  await Future.delayed(const Duration(seconds: 1), () {});
  printColor('  < ($simpleNumbersBuilds) yield 1', color);
  yield 1;
  await Future.delayed(const Duration(seconds: 1), () {});
  printColor('  < ($simpleNumbersBuilds) yield 2', color);
  yield 2;
  await Future.delayed(const Duration(seconds: 1), () {});
  printColor('  < ($simpleNumbersBuilds) yield 3', color);
  yield 3;

  // await Future.delayed(const Duration(seconds: 1), () {});
  // printColor('  < ($simpleNumbersBuilds) invalidate', color);
  // ref.invalidateSelf();
}

/// Number of times [streamDoublerProvider] is built.
int streamDoublerBuilds = 0;

/// This stream doubler demo does not work if used by itself. I think it stop watching
/// after yielding and causes the simpleNumberProvider to be disposed and
/// rebuilt.
@riverpod
Stream<int> streamDoubler(StreamDoublerRef ref) async* {
  const color = ConsoleColors.red;
  addDebug('streamDoubler', ++streamDoublerBuilds, color, ref.onDispose);

  final number = await ref.watch(simpleNumbersProvider.future);
  printColor('  > streamDoubler($streamDoublerBuilds) > $number', color);
  yield number * 2;
}

@riverpod
Stream<int> streamLoopDoubler(StreamLoopDoublerRef ref) async* {
  const color = ConsoleColors.red;
  addDebug('streamLoopDoubler', ++streamDoublerBuilds, color, ref.onDispose);

  // Doesn't work. think it infinite loops.
  // while (true) {
  //   final number = await ref.watch(simpleNumbersProvider.future);
  //   printColor('  > streamLoopDoubler(x) > $number', color);
  //   yield number * 2;
  // }
}

/// Demonstrates broken looping behavior due to [simpleNumbersProviders] being
/// unexpectedly disposed.
class StreamLoopDoublerDemo extends ConsumerWidget {
  const StreamLoopDoublerDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(streamLoopDoublerProvider).when(
        // Prevents flickering due to the [streamDoublerProvider] being rebuilt.
        // skipLoadingOnReload: true,
        data: (data) => data.toString(),
        error: (e, st) => '$e, $st',
        loading: () {
          printColor('StreamDoublerDemo loading...', ConsoleColors.white);
          return 'loading...';
        });

    return Text('Stream loop doubler demo: $value');
  }
}

/// Demonstrates broken looping behavior due to [simpleNumbersProviders] being
/// unexpectedly disposed.
class BrokenStreamDoublerDemo extends ConsumerWidget {
  const BrokenStreamDoublerDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(streamDoublerProvider).when(
        // Prevents flickering due to the [streamDoublerProvider] being rebuilt.
        // skipLoadingOnReload: true,
        data: (data) => data.toString(),
        error: (e, st) => '$e, $st',
        loading: () {
          printColor(
              'Broken StreamDoublerDemo loading...', ConsoleColors.white);
          return 'loading...';
        });

    return Text('Broken Stream doubler demo: $value');
  }
}

class StreamDoublerDemo extends ConsumerWidget {
  const StreamDoublerDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // !!! IMPORTANT !!!
    //
    // Without this watch, the [streamDoublerProvider] will
    // dispose of itself and the [simpleNumbersProvider] that it has been
    // watching, this causes a loop of the first value yielded by
    // [simpleNumbersProvider].
    //
    // This is not a good pattern (breaks encapsulation) since the goal is to
    // not have to know that [streamDoublerProvider] depends on
    // [simpleNumbersProvider].
    ref.watch(simpleNumbersProvider);

    final value = ref.watch(streamDoublerProvider).when(
        // Prevents flickering due to the [streamDoublerProvider] being rebuilt.
        skipLoadingOnReload: true,
        data: (data) => data.toString(),
        error: (e, st) => '$e, $st',
        loading: () {
          printColor(' StreamDoublerDemo loading...', ConsoleColors.white);
          return 'loading...';
        });

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
  addDebug('futureDoubler', ++futureDoublerBuilds, color, ref.onDispose);

  final number = await ref.watch(simpleNumbersProvider.future);
  printColor('  > futureDoubler($futureDoublerBuilds) > $number', color);
  return number * 2;
}

class FutureDoublerDemo extends ConsumerWidget {
  const FutureDoublerDemo({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(futureDoublerProvider).when(
        // Prevents flickering due to the provider being rebuilt.
        skipLoadingOnReload: true,
        data: (data) => data.toString(),
        error: (e, st) => '$e, $st',
        loading: () {
          printColor(' FutureDoublerDemo loading...', ConsoleColors.white);
          return 'loading...';
        });

    return Text('Future doubler demo: $value');
  }
}

final demos = [
  const FutureDoublerDemo(),
  const BrokenStreamDoublerDemo(),
  const StreamDoublerDemo(),
];

class StreamDemos extends StatefulWidget {
  const StreamDemos({super.key});

  @override
  State<StreamDemos> createState() => _StreamDemosState();
}

class _StreamDemosState extends State<StreamDemos> {
  late Widget? selected;
  bool reset = false;

  @override
  void initState() {
    super.initState();
    selected = demos.firstOrNull;
  }

  @override
  Widget build(BuildContext context) {
    printColor('Resetting', ConsoleColors.white);
    return Column(children: [
      DropdownButton(
          value: selected,
          items: demos
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.toString(),
                  ),
                ),
              )
              .toList(),
          onChanged: (e) {
            setState(() {
              selected = null;
            });
            SchedulerBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() => selected = e);
              }
            });
          }),
      const SizedBox(height: 20.0),
      Builder(
        builder: (_) => selected ?? const Text('Select a demo! 👆'),
      ),
    ]);
  }
}
