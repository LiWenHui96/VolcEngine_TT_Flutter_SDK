import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_volc_engine_tt_method_channel.dart';

abstract class FlutterVolcEngineTtPlatform extends PlatformInterface {
  /// Constructs a FlutterVolcEngineTtPlatform.
  FlutterVolcEngineTtPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterVolcEngineTtPlatform _instance =
      MethodChannelFlutterVolcEngineTt();

  /// The default instance of [FlutterVolcEngineTtPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterVolcEngineTt].
  static FlutterVolcEngineTtPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterVolcEngineTtPlatform] when
  /// they register themselves.
  static set instance(FlutterVolcEngineTtPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
