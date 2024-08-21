// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'future_or.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$futureOrDoublerHash() => r'825807e53b6a5f25c2cf7c64f6bf3232a0c65bd2';

/// A [FutureOr] provider that explicitly determines the synchronous nature of
/// the dependency.
///
/// Copied from [futureOrDoubler].
@ProviderFor(futureOrDoubler)
final futureOrDoublerProvider = AutoDisposeFutureProvider<int>.internal(
  futureOrDoubler,
  name: r'futureOrDoublerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$futureOrDoublerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FutureOrDoublerRef = AutoDisposeFutureProviderRef<int>;
String _$syncDoublerHash() => r'2dbdfedc208128ff6b8c62f13a07c8ed934335f3';

/// A [FutureOr] provider that uses convenience functions to work with the
/// synchronous nature of the dependency.
///
/// Copied from [syncDoubler].
@ProviderFor(syncDoubler)
final syncDoublerProvider = AutoDisposeFutureProvider<int>.internal(
  syncDoubler,
  name: r'syncDoublerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$syncDoublerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SyncDoublerRef = AutoDisposeFutureProviderRef<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
