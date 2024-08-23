import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test/test.dart';

import '../container.dart';

part 'combining_providers_test.g.dart';

@riverpod
Future<int> number(NumberRef ref) async {
  throw UnimplementedError();
}

@riverpod
Future<String> string(StringRef ref) {
  throw UnimplementedError();
}

/// A very simple way to combine two async providers. However, this will always
/// emit an initial loading state - even if using a [FutureOr], due to the async.
@riverpod
FutureOr<(int, String)> simpleCombined(SimpleCombinedRef ref) async {
  final number = await ref.watch(numberProvider.future);
  final string = await ref.watch(stringProvider.future);

  return (number, string);
}

/// A more advanced FutureOr provider that can skip the loading state if both
/// dependencies are already available.
@riverpod
FutureOr<(int, String)> advancedCombined(AdvancedCombinedRef ref) {
  final numberAsync = ref.read(numberProvider);
  final numberReady = numberAsync.hasValue || numberAsync.hasError;
  final stringAsync = ref.read(stringProvider);
  final stringReady = stringAsync.hasValue || stringAsync.hasError;

  if (numberReady && stringReady) {
    return (numberAsync.requireValue, stringAsync.requireValue);
  } else {
    return ref.watch(numberProvider.future).then((v) {
      return ref.watch(stringProvider.future).then((s) {
        return (v, s);
      });
    });
  }
}

void main() {
  late ProviderContainer container;
  late Completer<int> intCompleter;
  late Completer<String> stringCompleter;

  setUp(() {
    intCompleter = Completer();
    stringCompleter = Completer();

    container = createContainer(
      overrides: [
        numberProvider.overrideWith((_) => intCompleter.future),
        stringProvider.overrideWith((_) => stringCompleter.future),
      ],
    );

    // Keep both base providers alive.
    container.listen(numberProvider, (_, __) {});
    container.listen(stringProvider, (_, __) {});
  });

  test('Combined providers.', () async {
    intCompleter.complete(1);

    expect(container.read(numberProvider).isLoading, isTrue);
    expect(container.read(stringProvider).isLoading, isTrue);
    expect(container.read(advancedCombinedProvider).isLoading, isTrue);
    expect(container.read(simpleCombinedProvider).isLoading, isTrue);

    await Future(() {});

    stringCompleter.complete('myString');

    // Completer completes in the future, so string and advancedCombined are
    // both still loading.
    expect(container.read(numberProvider).value, 1);
    expect(container.read(stringProvider).isLoading, isTrue);
    expect(container.read(advancedCombinedProvider).isLoading, isTrue);
    // Simple combined provider is always loading because it's rebuilt.
    expect(container.read(simpleCombinedProvider).isLoading, isTrue);

    await Future(() {});

    // Everything is loaded and ready.
    expect(container.read(stringProvider).value, 'myString');
    expect(container.read(advancedCombinedProvider).isLoading, isFalse);
    expect(container.read(advancedCombinedProvider).value, (1, 'myString'));
    // Simple combined provider is always loading because it's rebuilt.
    expect(container.read(simpleCombinedProvider).isLoading, isTrue);

    // Keep the simple combined provider alive to get a value.
    container.listen(simpleCombinedProvider, (_, __) {});
    expect(container.read(simpleCombinedProvider).isLoading, isTrue);
    await Future(() {});
    expect(container.read(advancedCombinedProvider).value, (1, 'myString'));
  });

  test('Base provider error.', () async {
    final intException = Exception('int');
    intCompleter.completeError(intException);
    stringCompleter.complete('myString');

    await Future(() {});

    expect(container.read(numberProvider).error, intException);
    expect(container.read(stringProvider).value, 'myString');
    expect(container.read(advancedCombinedProvider).error, intException);
  });

  test('Base provider error.', () async {
    final intException = Exception('int');
    final stringException = Exception('int');

    stringCompleter.completeError(stringException);

    await Future(() {});

    intCompleter.completeError(intException);
    // Loading due to await on stringProvider.
    expect(container.read(advancedCombinedProvider).isLoading, isTrue);

    await Future(() {});

    expect(container.read(numberProvider).error, intException);
    expect(container.read(stringProvider).error, stringException);

    // Exception is based on await order in the combined provider.
    expect(container.read(advancedCombinedProvider).error, intException);
  });
}
