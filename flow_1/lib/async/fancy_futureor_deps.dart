import 'dart:async';

import 'package:flow_1/helpers/debug.dart';
import 'package:flow_1/helpers/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fancy_futureor_deps.g.dart';

/// This file demonstrates the depending on a [FutureProvider] inside another
/// [Future] and [FutureOr] provider.

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

/// Number of times the [futureOrDoublerProvider] is built.
int futureOrNumberDoublerBuilds = 0;

/// Doubler for watched future number.
/// Using [FutureOr] will not enter loading state if a value is already available.
@riverpod
FutureOr<int> futureOrNumberDoubler(FutureOrNumberDoublerRef ref) {
  addDebug('futureOrNumberDoubler', ++futureOrNumberDoublerBuilds,
      ConsoleColors.green, ref.onDispose);
  // [unwarpPrevious] is needed to prevent caching previous value when invalidated.
  final numberAsync = ref.read(futureNumberNotifierProvider).unwrapPrevious();

  if (numberAsync.hasValue || numberAsync.hasError) {
    return numberAsync.requireValue * 2;
  } else {
    return ref.watch(futureNumberNotifierProvider.future).then((v) => v * 2);
  }
}

/// Number of times the [futureOrDoublerProvider] is built.
int futureNumberTriplerBuilds = 0;

/// Tripler using [Future] results in a loading state even if value is already available.
@riverpod
Future<int> futureNumberTripler(FutureNumberTriplerRef ref) async {
  addDebug('futureNumberTripler', ++futureNumberTriplerBuilds,
      ConsoleColors.green, ref.onDispose);

  // [unwarpPrevious] is needed to prevent caching previous value when invalidated.
  final numberAsync = ref.read(futureNumberNotifierProvider).unwrapPrevious();

  if (numberAsync.hasValue || numberAsync.hasError) {
    return Future.value(numberAsync.requireValue * 3);
  } else {
    return ref.watch(futureNumberNotifierProvider.future).then((v) => v * 3);
  }
}

class FutureNumberDemo extends ConsumerStatefulWidget {
  const FutureNumberDemo({super.key});

  @override
  ConsumerState<FutureNumberDemo> createState() => _FutureNumberDemoState();
}

int iteration = 42;

class _FutureNumberDemoState extends ConsumerState<FutureNumberDemo> {
  final widgets = [];

  @override
  Widget build(BuildContext context) {
    // [unwarpPrevious] is needed to prevent caching previous value when invalidated.
    final asyncValue = ref.watch(futureNumberNotifierProvider).unwrapPrevious();

    final value = asyncValue.when(
      data: (data) => data.toString(),
      loading: () => 'loading...',
      error: (e, st) => 'error: $e, $st',
    );

    return Wrap(
      runSpacing: 20.0,
      spacing: 20.0,
      direction: Axis.vertical,
      children: [
        const Text('FutureOr providers demo.'),
        Text('  futureNumberNotifierProvider: $value'),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.0,
          children: [
            ElevatedButton(
              onPressed: () => !asyncValue.isLoading
                  ? ref.invalidate(futureNumberNotifierProvider)
                  : ref
                      .read(futureNumberNotifierProvider.notifier)
                      .finish(iteration++),
              child:
                  !asyncValue.isLoading ? const Text('💨') : const Text('💥'),
            ),
            ElevatedButton(
                onPressed: () => setState(() {
                      widgets.add(const FutureOrNumberDoublerDemo());
                    }),
                child: const Text('add 🔥🔥')),
            ElevatedButton(
                onPressed: () => setState(() {
                      widgets.add(const FutureNumberTriplerDemo());
                    }),
                child: const Text('add 🔥🔥🔥')),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    widgets.clear();
                  });
                  ref.invalidate(futureNumberNotifierProvider);
                },
                child: const Text('🗑️')),
          ],
        ),
        ...widgets,
      ],
    );
  }
}

class FutureOrNumberDoublerDemo extends ConsumerWidget {
  const FutureOrNumberDoublerDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(futureOrNumberDoublerProvider).when(
        data: (data) => data.toString(),
        error: (e, st) => '$e, $st',
        loading: () {
          printColor('FutureOrDoublerDemo loading...', ConsoleColors.white);
          return 'loading...';
        });

    return Text('FutureOr number doubler demo: $value');
  }
}

class FutureNumberTriplerDemo extends ConsumerWidget {
  const FutureNumberTriplerDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(futureNumberTriplerProvider).when(
        data: (data) => data.toString(),
        error: (e, st) => '$e, $st',
        loading: () {
          printColor('FutureNumberTripler loading...', ConsoleColors.white);
          return 'loading...';
        });

    return Text('Future number tripler demo: $value');
  }
}
