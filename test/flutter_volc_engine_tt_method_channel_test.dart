import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MethodChannelFlutterVolcEngineTt platform =
      MethodChannelFlutterVolcEngineTt();
  const MethodChannel channel = MethodChannel('flutter_volc_engine_tt');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
