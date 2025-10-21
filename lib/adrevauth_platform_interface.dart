import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'adrevauth_method_channel.dart';

abstract class AdrevauthPlatform extends PlatformInterface {
  /// Constructs a AdrevauthPlatform.
  AdrevauthPlatform() : super(token: _token);

  static final Object _token = Object();

  static AdrevauthPlatform _instance = MethodChannelAdrevauth();

  /// The default instance of [AdrevauthPlatform] to use.
  ///
  /// Defaults to [MethodChannelAdrevauth].
  static AdrevauthPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AdrevauthPlatform] when
  /// they register themselves.
  static set instance(AdrevauthPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Stream<bool> get onAuthStateChanged {
    throw UnimplementedError('onAuthStateChanged has not been implemented.');
  }

  Future<bool> isSignedIn() {
    throw UnimplementedError('isSignedIn() has not been implemented.');
  }
}
