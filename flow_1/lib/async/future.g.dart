// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$futureNumberHash() => r'0a47e33b52409c7aab90a2434a48b2542aae29c6';

/// Returns a number after a delay.
///
/// Copied from [futureNumber].
@ProviderFor(futureNumber)
final futureNumberProvider = AutoDisposeFutureProvider<int>.internal(
  futureNumber,
  name: r'futureNumberProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$futureNumberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FutureNumberRef = AutoDisposeFutureProviderRef<int>;
String _$watchedFutureDoublerHash() =>
    r'b192875536fc52194da16e4223d1d407b52fde17';

/// Doubler for watched future number.
///
/// Copied from [watchedFutureDoubler].
@ProviderFor(watchedFutureDoubler)
final watchedFutureDoublerProvider = AutoDisposeFutureProvider<int>.internal(
  watchedFutureDoubler,
  name: r'watchedFutureDoublerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchedFutureDoublerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchedFutureDoublerRef = AutoDisposeFutureProviderRef<int>;
String _$watchedFutureTriplerHash() =>
    r'bc03175f66c98d2a70f10d57dc4ce1133c81cc3f';

/// Tripler for watched future number.
///
/// Copied from [watchedFutureTripler].
@ProviderFor(watchedFutureTripler)
final watchedFutureTriplerProvider = AutoDisposeFutureProvider<int>.internal(
  watchedFutureTripler,
  name: r'watchedFutureTriplerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$watchedFutureTriplerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef WatchedFutureTriplerRef = AutoDisposeFutureProviderRef<int>;
String _$futureNumberNotifierHash() =>
    r'78792c6dbf9d07e001da3afd72f0e704abc653b8';

/// A notifier that returns a future that can be completed by calling [finish].
///
/// Copied from [FutureNumberNotifier].
@ProviderFor(FutureNumberNotifier)
final futureNumberNotifierProvider =
    AutoDisposeAsyncNotifierProvider<FutureNumberNotifier, int>.internal(
  FutureNumberNotifier.new,
  name: r'futureNumberNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$futureNumberNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FutureNumberNotifier = AutoDisposeAsyncNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
