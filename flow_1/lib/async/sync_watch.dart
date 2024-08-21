import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// From: https://github.com/rrousselGit/riverpod/issues/3359
///
/// A set of helper extensions to help streamline producing and using
/// [FutureOr]s in Riverpod providers.
extension SyncWatch on Ref {
  FutureOr<T> streamSyncWatch<T>(StreamProvider<T> provider) {
    final hasResult = read(provider.select((v) => v.hasValue || v.hasError));

    if (!hasResult) return watch(provider.future);

    return watch(provider).requireValue;
  }

  FutureOr<T> futureSyncWatch<T>(FutureProvider<T> provider) {
    final hasResult = read(provider.select((v) => v.hasValue || v.hasError));

    if (!hasResult) return watch(provider.future);

    return watch(provider).requireValue;
  }
}

/// AutoDisposeRef exposes the required watch function to handle
/// non-[AlwaysAliveProviderListenable].
//
// IMO, this is too clunky to use as the watcher needs to know the provider's
// keepAlive status
extension AutoDisposeSyncWatch on AutoDisposeRef {
  FutureOr<T> autoDisposeStreamSyncWatch<T>(
      AutoDisposeStreamProvider<T> provider) {
    final hasResult = read(provider.select((v) => v.hasValue || v.hasError));
    if (!hasResult) return watch(provider.future);
    return watch(provider).requireValue;
  }
}

/// Convenience extension to add then() to [FutureOr], executes function
/// synchronously if possible.
extension Then<T> on FutureOr<T> {
  FutureOr<R> then<R>(
    FutureOr<R> Function(T value) onValue,
  ) {
    if (this is T) {
      return onValue(this as T);
    } else {
      return (() async => onValue(await this))();
    }
  }
}
