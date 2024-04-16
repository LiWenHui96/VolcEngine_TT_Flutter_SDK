import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_volcengine_video/flutter_volcengine_video.dart';
import 'package:flutter_volcengine_video/flutter_volcengine_video_method_channel.dart';
import 'package:flutter_volcengine_video/flutter_volcengine_video_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterVolcengineVideoPlatform
    with MockPlatformInterfaceMixin
    implements FlutterVolcengineVideoPlatform {
  @override
  Future<String?> getPlatformVersion() => Future<String>.value('42');
}

void main() {
  final FlutterVolcengineVideoPlatform initialPlatform =
      FlutterVolcengineVideoPlatform.instance;

  test('$MethodChannelFlutterVolcengineVideo is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelFlutterVolcengineVideo>());
  });

  test('getPlatformVersion', () async {
    final FlutterVolcengineVideo flutterVolcengineVideoPlugin =
        FlutterVolcengineVideo();
    final MockFlutterVolcengineVideoPlatform fakePlatform =
        MockFlutterVolcengineVideoPlatform();
    FlutterVolcengineVideoPlatform.instance = fakePlatform;

    expect(await flutterVolcengineVideoPlugin.getPlatformVersion(), '42');
  });
}
