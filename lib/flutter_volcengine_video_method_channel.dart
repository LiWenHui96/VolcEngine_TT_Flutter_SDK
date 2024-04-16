import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_volcengine_video_platform_interface.dart';

/// An implementation of [FlutterVolcengineVideoPlatform] that uses method
/// channels.
class MethodChannelFlutterVolcengineVideo
    extends FlutterVolcengineVideoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel =
      const MethodChannel('flutter_volcengine_video');

  @override
  Future<String?> getPlatformVersion() async {
    final String? version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
