import 'package:flow_1/async/streams.dart';
import 'package:flow_1/async/sync_watch.dart';
import 'package:flow_1/helpers/debug.dart';
import 'package:flow_1/helpers/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'future_or.g.dart';

/// Number of times the [futureOrDoublerProvider] is built.
int futureOrDoublerBuilds = 0;

/// A [FutureOr] provider that explicitly determines the synchronous nature of
/// the dependency.
@riverpod
FutureOr<int> futureOrDoubler(FutureOrDoublerRef ref) {
  const color = ConsoleColors.magenta;
  addDebug('futureOrDoubler', ++futureOrDoublerBuilds, color, ref.onDispose);

  // Use `read` here since
  final hasResult =
      ref.read(simpleNumbersProvider.select((v) => v.hasValue || v.hasError));

  if (hasResult) {
    return ref.watch(simpleNumbersProvider).requireValue * 2;
  } else {
    return ref.watch(simpleNumbersProvider.future).then((number) => number * 2);
  }
}

class FutureOrDoublerDemo extends ConsumerWidget {
  const FutureOrDoublerDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(futureOrDoublerProvider).when(
        data: (data) => data.toString(),
        error: (e, st) => '$e, $st',
        loading: () {
          printColor('FutureOrDoublerDemo loading...', ConsoleColors.white);
          return 'loading...';
        });

    return Text('FutureOr doubler demo: $value');
  }
}

/// Number of times the [syncDoublerProvider] is built.
int syncDoublerBuilds = 0;

/// A [FutureOr] provider that uses convenience functions to work with the
/// synchronous nature of the dependency.
@riverpod
FutureOr<int> syncDoubler(SyncDoublerRef ref) {
  const color = ConsoleColors.magenta;
  addDebug('syncDoubler', ++syncDoublerBuilds, color, ref.onDispose);

  // Having to use this is quite clunky.
  final number = ref.autoDisposeStreamSyncWatch(simpleNumbersProvider);
  return number.then((v) => v * 2);
}

class SyncDoublerDemo extends ConsumerWidget {
  const SyncDoublerDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(syncDoublerProvider).when(
        data: (data) => data.toString(),
        error: (e, st) => '$e, $st',
        loading: () {
          printColor('SyncDoublerDemo loading...', ConsoleColors.white);
          return 'loading...';
        });

    return Text('Sync doubler demo: $value');
  }
}
