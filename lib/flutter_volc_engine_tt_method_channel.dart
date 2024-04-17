import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_volc_engine_tt_platform_interface.dart';

/// An implementation of [FlutterVolcEngineTtPlatform] that uses method
/// channels.
class MethodChannelFlutterVolcEngineTt extends FlutterVolcEngineTtPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel =
      const MethodChannel('flutter_volc_engine_tt');

  @override
  Future<String?> getPlatformVersion() async {
    final String? version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
