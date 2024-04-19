part of flutter_volc_engine_tt;

class FlutterVolcEngineTT {
  static final FlutterVolcEngineTT _instance = FlutterVolcEngineTT();

  static FlutterVolcEngineTT get instance => _instance;

  /// License鉴权状态
  LicenseStatus status = LicenseStatus.NONE;

  /// {@macro flutter.volc.engine.tt.platform.initVodSDK}
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
    final LicenseStatus licenseState =
        await FlutterVolcEngineTTPlatform.instance.initVodSDK(
      appId: appId,
      licenseName: licenseName,
      appName: appName,
      appVersion: appVersion,
      appChannel: appChannel,
      cacheDirPath: cacheDirPath,
      maxCacheSize: maxCacheSize,
      userId: userId,
      isDebug: isDebug,
    );
    status = licenseState;
    return licenseState;
  }

  /// {@macro flutter.volc.engine.tt.platform.setUserUniqueId}
  Future<void> setUserUniqueId(String userId) {
    return FlutterVolcEngineTTPlatform.instance.setUserUniqueId(userId);
  }

  /// {@macro flutter.volc.engine.tt.platform.clearUserUniqueId}
  Future<void> clearUserUniqueId() {
    return FlutterVolcEngineTTPlatform.instance.clearUserUniqueId();
  }
}

/// The id of the view used by the plugin.
const String viewTypeId = 'flutter_volc_engine_tt/video';

/// Android 默认缓存地址文件夹名称
const String kCacheDir = 'FlutterVolcEngineTTCache';

/// Android 渠道默认值
const String kAppChannel = 'FlutterVolcEngineTT';

/// Android 版本号合规验证
bool isAppVersion(String input) {
  if (input.isEmpty) return false;
  return RegExp(r'^\d+(\.\d+){2,}$').hasMatch(input);
}

/// 默认缓存地址文件夹大小
/// Android 300 * 1024 * 1024 (300MB)
/// iOS 100 * 1024 * 1024 (100MB)
int kMaxCacheSize = (isIOS ? 100 : 300) * 1024 * 1024;

/// Whether the operating system is a version of
/// [Android](https://en.wikipedia.org/wiki/Android_%28operating_system%29).
bool isAndroid = defaultTargetPlatform == TargetPlatform.android;

/// Whether the operating system is a version of
/// [iOS](https://en.wikipedia.org/wiki/IOS).
bool isIOS = defaultTargetPlatform == TargetPlatform.iOS;

/// 代替[SystemUiOverlayStyle.dark]
SystemUiOverlayStyle kDark = const SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);

/// 代替[SystemUiOverlayStyle.light]
SystemUiOverlayStyle kLight = const SystemUiOverlayStyle(
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);
