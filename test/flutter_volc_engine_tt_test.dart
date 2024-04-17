import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt_method_channel.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterVolcEngineTtPlatform
    with MockPlatformInterfaceMixin
    implements FlutterVolcEngineTtPlatform {
  @override
  Future<String?> getPlatformVersion() => Future<String>.value('42');
}

void main() {
  final FlutterVolcEngineTtPlatform initialPlatform =
      FlutterVolcEngineTtPlatform.instance;

  test('$MethodChannelFlutterVolcEngineTt is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterVolcEngineTt>());
  });

  test('getPlatformVersion', () async {
    final FlutterVolcEngineTt flutterVolcEngineTtPlugin = FlutterVolcEngineTt();
    final MockFlutterVolcEngineTtPlatform fakePlatform =
        MockFlutterVolcEngineTtPlatform();
    FlutterVolcEngineTtPlatform.instance = fakePlatform;

    expect(await flutterVolcEngineTtPlugin.getPlatformVersion(), '42');
  });
}
