import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt_method_channel.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt_platform_interface.dart';

void main() {
  final FlutterVolcEngineTTPlatform initialPlatform =
      FlutterVolcEngineTTPlatform.instance;

  test('$MethodChannelFlutterVolcEngineTT is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterVolcEngineTT>());
  });
}
