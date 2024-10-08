// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'streams.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$simpleNumbersHash() => r'95545b209158d3c76fff7832e395f520b18a3c22';

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
String _$streamDoublerHash() => r'aba81a6ec192ca52a8fb4de657cd160896e64143';

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
String _$streamLoopDoublerHash() => r'7d9b3256fe43465e80fa43a101b0f91ad0f72da0';

/// See also [streamLoopDoubler].
@ProviderFor(streamLoopDoubler)
final streamLoopDoublerProvider = AutoDisposeStreamProvider<int>.internal(
  streamLoopDoubler,
  name: r'streamLoopDoublerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$streamLoopDoublerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StreamLoopDoublerRef = AutoDisposeStreamProviderRef<int>;
String _$futureDoublerHash() => r'adf7fcb4f235aada2fff7ca9737236a69294779f';

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
