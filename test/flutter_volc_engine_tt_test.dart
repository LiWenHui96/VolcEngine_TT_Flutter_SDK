import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt_method_channel.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterVolcEngineTTPlatform
    with MockPlatformInterfaceMixin
    implements FlutterVolcEngineTTPlatform {
  @override
  Future<String?> getPlatformVersion() => Future<String>.value('42');
}

void main() {
  final FlutterVolcEngineTTPlatform initialPlatform =
      FlutterVolcEngineTTPlatform.instance;

  test('$MethodChannelFlutterVolcEngineTT is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterVolcEngineTT>());
  });

  test('getPlatformVersion', () async {
    final FlutterVolcEngineTT flutterVolcEngineTTPlugin = FlutterVolcEngineTT();
    final MockFlutterVolcEngineTTPlatform fakePlatform =
        MockFlutterVolcEngineTTPlatform();
    FlutterVolcEngineTTPlatform.instance = fakePlatform;

    expect(await flutterVolcEngineTTPlugin.getPlatformVersion(), '42');
  });
}
