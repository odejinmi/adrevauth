import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'adrevauth_platform_interface.dart';

/// An implementation of [AdrevauthPlatform] that uses method channels.
class MethodChannelAdrevauth extends AdrevauthPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('adrevauth');

  @visibleForTesting
  final eventChannel = const EventChannel('adrevauth/auth_state');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }


  @override
  Stream<bool> get onAuthStateChanged {
    return eventChannel.receiveBroadcastStream().map((event) => event as bool);
  }

  @override
  Future<bool> isSignedIn() async {
    final isSignedIn = await methodChannel.invokeMethod<bool>('isSignedIn');
    return isSignedIn ?? false;
  }
}
