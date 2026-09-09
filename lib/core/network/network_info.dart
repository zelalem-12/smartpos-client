import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract online/offline status so tests can inject a fixed value.
abstract class NetworkInfo {
  /// Whether the device is currently connected to a network.
  Future<bool> get isOnline;

  /// Emits `true` when connectivity changes to online and `false` when offline.
  Stream<bool> get onOnlineChanged;
}

/// [NetworkInfo] backed by the connectivity_plus plugin.
///
/// Listens to connectivity changes and disposes the underlying subscription
/// when the stream is cancelled to avoid leaks.
class ConnectivityNetworkInfo implements NetworkInfo {
  final Connectivity _connectivity;

  const ConnectivityNetworkInfo(this._connectivity);

  @override
  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    return _isOnline(results);
  }

  @override
  Stream<bool> get onOnlineChanged {
    return _connectivity.onConnectivityChanged.map(_isOnline);
  }

  static bool _isOnline(List<ConnectivityResult> results) {
    return results.any((r) => r != ConnectivityResult.none);
  }
}
