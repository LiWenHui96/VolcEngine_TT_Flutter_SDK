import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_volc_engine_tt.dart';
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

  /// {@template flutter.volc.engine.tt.platform.initVodSDK}
  /// 初始化VodSDK
  /// Android: https://www.volcengine.com/docs/4/112130
  /// iOS: https://www.volcengine.com/docs/4/112131
  ///
  /// [appId] AppID，从控制台 -> 应用管理获取。
  ///
  /// [licenseName] License 文件地址。
  /// 参数均为 `xxx`
  /// Android: 放置在 flutter 目录下 `assets/license/xxx.lic` 路径
  /// iOS: 放置在 Xcode -> Runner -> xxx.lic 路径
  ///
  /// [appName] App 英文名，从控制台 -> 应用管理获取。
  ///
  /// [appVersion] App 版本号
  ///
  /// [appChannel] 渠道号，业务自定义，默认为[kAppChannel]。
  ///
  /// [cacheDirPath] Android 视频缓存路径，默认为[kCacheDir]。
  ///
  /// [maxCacheSize] 视频缓存文件夹大小，默认值为[kMaxCacheSize]。
  ///
  /// [userId] 自定义 ID，用于实现单点追查功能，即进行用户级和播放会话级的全链路问题定位和追踪。
  /// Android: https://www.volcengine.com/docs/4/161480
  /// iOS: https://www.volcengine.com/docs/4/171486
  ///
  /// [isDebug] 是否开启日志调试，建议线上版本关闭日志，减少性能开销。
  /// 默认为false，建议使用[kDebugMode]。
  ///
  /// 返回值为鉴权状态
  /// {@endtemplate}
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
  }) {
    throw UnimplementedError('initVodSDK() has not been implemented.');
  }

  /// {@template flutter.volc.engine.tt.platform.setUserUniqueId}
  /// 设置自定义ID
  /// 用于实现单点追查功能，即进行用户级和播放会话级的全链路问题定位和追踪。
  ///
  /// 初始化/登录成功/切换登录后调用，以更新自定义ID。
  ///
  /// 如何使用自定义ID
  /// Android: https://www.volcengine.com/docs/4/161480
  /// iOS: https://www.volcengine.com/docs/4/171486
  /// {@endtemplate}
  Future<void> setUserUniqueId(String userId) {
    throw UnimplementedError('setUserUniqueId() has not been implemented.');
  }

  /// {@template flutter.volc.engine.tt.platform.clearUserUniqueId}
  /// 清除自定义ID
  ///
  /// 退出登录后调用，以更新自定义ID。
  /// {@endtemplate}
  Future<void> clearUserUniqueId() {
    throw UnimplementedError('clearUserUniqueId() has not been implemented.');
  }
}
