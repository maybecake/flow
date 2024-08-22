// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_to_futureor_test.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$simpleStreamHash() => r'8d4e2e5ab2ff8cc140dcc682723e0f744c3cd1c8';

/// Demonstrate how to convert a Stream provider to a FutureOr provider.
///
/// Copied from [simpleStream].
@ProviderFor(simpleStream)
final simpleStreamProvider = AutoDisposeStreamProvider<int>.internal(
  simpleStream,
  name: r'simpleStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$simpleStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SimpleStreamRef = AutoDisposeStreamProviderRef<int>;
String _$futureOrDoublerHash() => r'24fa8ee114928498c2cf47681be03d828ce874ab';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [futureOrDoubler].
@ProviderFor(futureOrDoubler)
const futureOrDoublerProvider = FutureOrDoublerFamily();

/// See also [futureOrDoubler].
class FutureOrDoublerFamily extends Family<AsyncValue<int>> {
  /// See also [futureOrDoubler].
  const FutureOrDoublerFamily();

  /// See also [futureOrDoubler].
  FutureOrDoublerProvider call(
    String family,
  ) {
    return FutureOrDoublerProvider(
      family,
    );
  }

  @override
  FutureOrDoublerProvider getProviderOverride(
    covariant FutureOrDoublerProvider provider,
  ) {
    return call(
      provider.family,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'futureOrDoublerProvider';
}

/// See also [futureOrDoubler].
class FutureOrDoublerProvider extends AutoDisposeFutureProvider<int> {
  /// See also [futureOrDoubler].
  FutureOrDoublerProvider(
    String family,
  ) : this._internal(
          (ref) => futureOrDoubler(
            ref as FutureOrDoublerRef,
            family,
          ),
          from: futureOrDoublerProvider,
          name: r'futureOrDoublerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$futureOrDoublerHash,
          dependencies: FutureOrDoublerFamily._dependencies,
          allTransitiveDependencies:
              FutureOrDoublerFamily._allTransitiveDependencies,
          family: family,
        );

  FutureOrDoublerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
  }) : super.internal();

  final String family;

  @override
  Override overrideWith(
    FutureOr<int> Function(FutureOrDoublerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FutureOrDoublerProvider._internal(
        (ref) => create(ref as FutureOrDoublerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _FutureOrDoublerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FutureOrDoublerProvider && other.family == family;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FutureOrDoublerRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `family` of this provider.
  String get family;
}

class _FutureOrDoublerProviderElement
    extends AutoDisposeFutureProviderElement<int> with FutureOrDoublerRef {
  _FutureOrDoublerProviderElement(super.provider);

  @override
  String get family => (origin as FutureOrDoublerProvider).family;
}

String _$futureDoublerHash() => r'5ba6a81cbcf27dee909b92532a5f57fa3350c4df';

/// See also [futureDoubler].
@ProviderFor(futureDoubler)
const futureDoublerProvider = FutureDoublerFamily();

/// See also [futureDoubler].
class FutureDoublerFamily extends Family<AsyncValue<int>> {
  /// See also [futureDoubler].
  const FutureDoublerFamily();

  /// See also [futureDoubler].
  FutureDoublerProvider call(
    String family,
  ) {
    return FutureDoublerProvider(
      family,
    );
  }

  @override
  FutureDoublerProvider getProviderOverride(
    covariant FutureDoublerProvider provider,
  ) {
    return call(
      provider.family,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'futureDoublerProvider';
}

/// See also [futureDoubler].
class FutureDoublerProvider extends AutoDisposeFutureProvider<int> {
  /// See also [futureDoubler].
  FutureDoublerProvider(
    String family,
  ) : this._internal(
          (ref) => futureDoubler(
            ref as FutureDoublerRef,
            family,
          ),
          from: futureDoublerProvider,
          name: r'futureDoublerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$futureDoublerHash,
          dependencies: FutureDoublerFamily._dependencies,
          allTransitiveDependencies:
              FutureDoublerFamily._allTransitiveDependencies,
          family: family,
        );

  FutureDoublerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
  }) : super.internal();

  final String family;

  @override
  Override overrideWith(
    FutureOr<int> Function(FutureDoublerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FutureDoublerProvider._internal(
        (ref) => create(ref as FutureDoublerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<int> createElement() {
    return _FutureDoublerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FutureDoublerProvider && other.family == family;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FutureDoublerRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `family` of this provider.
  String get family;
}

class _FutureDoublerProviderElement
    extends AutoDisposeFutureProviderElement<int> with FutureDoublerRef {
  _FutureDoublerProviderElement(super.provider);

  @override
  String get family => (origin as FutureDoublerProvider).family;
}

String _$streamDoublerHash() => r'd9f12971054e37df94986e6933c041605fec9dd6';

/// See also [streamDoubler].
@ProviderFor(streamDoubler)
const streamDoublerProvider = StreamDoublerFamily();

/// See also [streamDoubler].
class StreamDoublerFamily extends Family<AsyncValue<int>> {
  /// See also [streamDoubler].
  const StreamDoublerFamily();

  /// See also [streamDoubler].
  StreamDoublerProvider call(
    String family,
  ) {
    return StreamDoublerProvider(
      family,
    );
  }

  @override
  StreamDoublerProvider getProviderOverride(
    covariant StreamDoublerProvider provider,
  ) {
    return call(
      provider.family,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'streamDoublerProvider';
}

/// See also [streamDoubler].
class StreamDoublerProvider extends AutoDisposeStreamProvider<int> {
  /// See also [streamDoubler].
  StreamDoublerProvider(
    String family,
  ) : this._internal(
          (ref) => streamDoubler(
            ref as StreamDoublerRef,
            family,
          ),
          from: streamDoublerProvider,
          name: r'streamDoublerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$streamDoublerHash,
          dependencies: StreamDoublerFamily._dependencies,
          allTransitiveDependencies:
              StreamDoublerFamily._allTransitiveDependencies,
          family: family,
        );

  StreamDoublerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.family,
  }) : super.internal();

  final String family;

  @override
  Override overrideWith(
    Stream<int> Function(StreamDoublerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StreamDoublerProvider._internal(
        (ref) => create(ref as StreamDoublerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        family: family,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<int> createElement() {
    return _StreamDoublerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StreamDoublerProvider && other.family == family;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, family.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StreamDoublerRef on AutoDisposeStreamProviderRef<int> {
  /// The parameter `family` of this provider.
  String get family;
}

class _StreamDoublerProviderElement
    extends AutoDisposeStreamProviderElement<int> with StreamDoublerRef {
  _StreamDoublerProviderElement(super.provider);

  @override
  String get family => (origin as StreamDoublerProvider).family;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
