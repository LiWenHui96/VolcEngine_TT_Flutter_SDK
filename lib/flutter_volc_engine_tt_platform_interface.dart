import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_volc_engine_tt_method_channel.dart';

abstract class FlutterVolcEngineTTPlatform extends PlatformInterface {
  /// Constructs a FlutterVolcEngineTTPlatform.
  FlutterVolcEngineTTPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterVolcEngineTTPlatform _instance =
      MethodChannelFlutterVolcEngineTT();

  /// The default instance of [FlutterVolcEngineTTPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterVolcEngineTT].
  static FlutterVolcEngineTTPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterVolcEngineTTPlatform] when
  /// they register themselves.
  static set instance(FlutterVolcEngineTTPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
