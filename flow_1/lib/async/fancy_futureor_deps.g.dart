// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fancy_futureor_deps.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$futureOrNumberDoublerHash() =>
    r'1c5e6c5bdc5ce118279011f7a8b985058af848d4';

/// Doubler for watched future number.
/// Using [FutureOr] will not enter loading state if a value is already available.
///
/// Copied from [futureOrNumberDoubler].
@ProviderFor(futureOrNumberDoubler)
final futureOrNumberDoublerProvider = AutoDisposeFutureProvider<int>.internal(
  futureOrNumberDoubler,
  name: r'futureOrNumberDoublerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$futureOrNumberDoublerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FutureOrNumberDoublerRef = AutoDisposeFutureProviderRef<int>;
String _$futureNumberTriplerHash() =>
    r'0c5c50874682aff6f8d2f36af1f8a72b7edac2ba';

/// Tripler using [Future] results in a loading state even if value is already available.
///
/// Copied from [futureNumberTripler].
@ProviderFor(futureNumberTripler)
final futureNumberTriplerProvider = AutoDisposeFutureProvider<int>.internal(
  futureNumberTripler,
  name: r'futureNumberTriplerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$futureNumberTriplerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FutureNumberTriplerRef = AutoDisposeFutureProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
