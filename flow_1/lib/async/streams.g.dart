// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streams.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$simpleNumbersHash() => r'6556f44f6d8358122cacd497b08a2d95a09c6a87';

/// Simple numbers tries to yield 1, 2, 3 in a [ProviderStream].
///
/// Copied from [simpleNumbers].
@ProviderFor(simpleNumbers)
final simpleNumbersProvider = AutoDisposeStreamProvider<int>.internal(
  simpleNumbers,
  name: r'simpleNumbersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$simpleNumbersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SimpleNumbersRef = AutoDisposeStreamProviderRef<int>;
String _$streamDoublerHash() => r'ccddf055147696f1bfabec380d49b17781e3155f';

/// This stream doubler demo does not work if used by itself. I think it stop watching
/// after yielding and causes the simpleNumberProvider to be disposed and
/// rebuilt.
///
/// Copied from [streamDoubler].
@ProviderFor(streamDoubler)
final streamDoublerProvider = AutoDisposeStreamProvider<int>.internal(
  streamDoubler,
  name: r'streamDoublerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$streamDoublerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StreamDoublerRef = AutoDisposeStreamProviderRef<int>;
String _$futureDoublerHash() => r'2d1413e77d2fa9c1f6d0aea1cff8b486f9d09848';

/// This works and does not cause the [simpleNumbersProvider] from disposing.
/// Having this at the same time as the [streamDoublerProvider] will cause that
/// to also work properly.
///
/// Copied from [futureDoubler].
@ProviderFor(futureDoubler)
final futureDoublerProvider = AutoDisposeFutureProvider<int>.internal(
  futureDoubler,
  name: r'futureDoublerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$futureDoublerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FutureDoublerRef = AutoDisposeFutureProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
