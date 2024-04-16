import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_volcengine_video_method_channel.dart';

abstract class FlutterVolcengineVideoPlatform extends PlatformInterface {
  /// Constructs a FlutterVolcengineVideoPlatform.
  FlutterVolcengineVideoPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterVolcengineVideoPlatform _instance =
      MethodChannelFlutterVolcengineVideo();

  /// The default instance of [FlutterVolcengineVideoPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterVolcengineVideo].
  static FlutterVolcengineVideoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterVolcengineVideoPlatform] when
  /// they register themselves.
  static set instance(FlutterVolcengineVideoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
