// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combining_providers_test.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$numberHash() => r'b7fd6cd74c403bdbeea2ad6eaa621ff82089de4a';

/// See also [number].
@ProviderFor(number)
final numberProvider = AutoDisposeFutureProvider<int>.internal(
  number,
  name: r'numberProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$numberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NumberRef = AutoDisposeFutureProviderRef<int>;
String _$stringHash() => r'25247ce7a55bcf1704987587c5a9cd284a746a8a';

/// See also [string].
@ProviderFor(string)
final stringProvider = AutoDisposeFutureProvider<String>.internal(
  string,
  name: r'stringProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$stringHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StringRef = AutoDisposeFutureProviderRef<String>;
String _$simpleCombinedHash() => r'eeae264727fb9b11486a45da42387bcd672f0dbc';

/// A very simple way to combine two async providers. However, this will always
/// emit an initial loading state.
///
/// Copied from [simpleCombined].
@ProviderFor(simpleCombined)
final simpleCombinedProvider =
    AutoDisposeFutureProvider<(int, String)>.internal(
  simpleCombined,
  name: r'simpleCombinedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$simpleCombinedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SimpleCombinedRef = AutoDisposeFutureProviderRef<(int, String)>;
String _$advancedCombinedHash() => r'fa87670344d71a365f31a417379ed86a17a609dd';

/// A more advanced FutureOr provider that can skip the loading state if both
/// dependencies are already available.
///
/// Copied from [advancedCombined].
@ProviderFor(advancedCombined)
final advancedCombinedProvider =
    AutoDisposeFutureProvider<(int, String)>.internal(
  advancedCombined,
  name: r'advancedCombinedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$advancedCombinedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AdvancedCombinedRef = AutoDisposeFutureProviderRef<(int, String)>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
