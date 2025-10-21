import 'package:flutter_test/flutter_test.dart';
import 'package:adrevauth/adrevauth.dart';
import 'package:adrevauth/adrevauth_platform_interface.dart';
import 'package:adrevauth/adrevauth_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAdrevauthPlatform
    with MockPlatformInterfaceMixin
    implements AdrevauthPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AdrevauthPlatform initialPlatform = AdrevauthPlatform.instance;

  test('$MethodChannelAdrevauth is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAdrevauth>());
  });

  test('getPlatformVersion', () async {
    Adrevauth adrevauthPlugin = Adrevauth();
    MockAdrevauthPlatform fakePlatform = MockAdrevauthPlatform();
    AdrevauthPlatform.instance = fakePlatform;

    expect(await adrevauthPlugin.getPlatformVersion(), '42');
  });
}
