import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_volc_engine_tt_platform_interface.dart';

/// An implementation of [FlutterVolcEngineTTPlatform] that uses method
/// channels.
class MethodChannelFlutterVolcEngineTT extends FlutterVolcEngineTTPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel =
      const MethodChannel('flutter_volc_engine_tt');
}
