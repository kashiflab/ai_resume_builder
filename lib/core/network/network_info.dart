import 'dart:io';

/// Network information utility class
class NetworkInfo {
  const NetworkInfo();

  /// Check if the device has an internet connection
  Future<bool> get isConnected => _checkConnection();

  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
