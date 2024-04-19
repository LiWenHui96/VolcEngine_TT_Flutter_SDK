import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_volc_engine_tt.dart';
import 'flutter_volc_engine_tt_platform_interface.dart';

/// An implementation of [FlutterVolcEngineTTPlatform] that uses method
/// channels.
class MethodChannelFlutterVolcEngineTT extends FlutterVolcEngineTTPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel =
      const MethodChannel('flutter_volc_engine_tt');

  @override
  Future<LicenseStatus> initVodSDK({
    required String appId,
    required String licenseName,
    required String appName,
    required String appVersion,
    required String? appChannel,
    String? cacheDirPath,
    int? maxCacheSize,
    String? userId,
    bool isDebug = false,
  }) async {
    assert(isAppVersion(appVersion), '请使用合法版本号，例如：1.0.0');

    String licensePath = licenseName;
    if (isAndroid) licensePath = 'assets/license/$licensePath';

    try {
      final int? result = await methodChannel.invokeMethod<int>(
        'initVodSDK',
        <String, dynamic>{
          'AppID': appId,
          'License': licensePath,
          'AppName': appName,
          'AppVersion': appVersion,
          'AppChannel': appChannel ?? kAppChannel,
          'CacheDirPath': cacheDirPath ?? kCacheDir,
          'MaxCacheSize': maxCacheSize ?? kMaxCacheSize,
          'UserUniqueId': userId,
          'isDebug': isDebug,
        },
      );
      return LicenseStatus.values.firstWhere(
        (_) => _.code == result,
        orElse: () => LicenseStatus.NONE,
      );
    } catch (e) {
      return LicenseStatus.NONE;
    }
  }

  @override
  Future<void> setUserUniqueId(String userId) {
    return methodChannel.invokeMethod('setUserUniqueId', <String, dynamic>{
      'UserUniqueId': userId,
    });
  }

  @override
  Future<void> clearUserUniqueId() {
    return methodChannel.invokeMethod('clearUserUniqueId');
  }
}
