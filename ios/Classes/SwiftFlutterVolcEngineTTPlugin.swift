import Flutter
import UIKit

public class SwiftFlutterVolcEngineTTPlugin: NSObject, FlutterPlugin {
  var registrar: FlutterPluginRegistrar

  init(registrar: FlutterPluginRegistrar) {
    self.registrar = registrar
  }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_volc_engine_tt", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterVolcEngineTTPlugin(registrar: registrar)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch (call.method) {
      case "initVodSDK":
        initVodSDK(arg: call.arguments as! [String: Any?], result: result)
        break
      case "setUserUniqueId":
        setUserUniqueId(arg: call.arguments as! [String: Any?])
      case "clearUserUniqueId":
        clearUserUniqueId()
      default:
        result(FlutterMethodNotImplemented)
        break
    }
  }

  /**
   * 初始化 VodSDK
   *
   * @param arg
   */
  func initVodSDK(arg: [String : Any?], result: @escaping FlutterResult) {
    // 是否开启日志调试
    let isDebug = arg["isDebug"] as! Bool
    if isDebug {
      TTVideoEngine.setLogFlag(TTVideoEngineLogFlag.all)
    }

    // 初始化信息
    let appId = arg["AppID"] as! String
    let licenseName = arg["License"] as! String
    let appName = arg["AppName"] as! String
    let appVersion = arg["AppVersion"] as! String
    let appChannel = arg["AppChannel"] as! String
    let configuration = TTSDKConfiguration.defaultConfiguration(withAppID: appId, licenseName: licenseName)
    configuration.appName = appName
    configuration.appVersion = appVersion
    configuration.channel = appChannel

    // 设置缓存信息
    // 默认大小为 100MB
    let defaultMaxCacheSize = 100 * 1024 * 1024
    let cacheDirPath = arg["CacheDirPath"] as! String
    let maxCacheSize = (arg["MaxCacheSize"] ?? defaultMaxCacheSize) as! Int
    let vodConfiguration = TTSDKVodConfiguration()
    vodConfiguration.cachePath = cacheDirPath
    vodConfiguration.cacheMaxSize = maxCacheSize
    configuration.vodConfiguration = vodConfiguration

    // 初始化
    TTSDKManager.start(with: configuration)

    // 设置自定义ID
    setUserUniqueId(arg: arg)

    // 监听 License 状态
    let TTLicenseNotificationLicenseDidAdd = Notification.Name("TTLicenseNotificationLicenseDidAdd")
    let TTLicenseNotificationLicenseResultKey = "TTLicenseNotificationLicenseResultKey"
    NotificationCenter.default.addObserver(forName: TTLicenseNotificationLicenseDidAdd, object: nil, queue: OperationQueue.main) { notification in
      let code = notification.userInfo?[TTLicenseNotificationLicenseResultKey] as? NSNumber
      result(code?.intValue)
    }
  }

  /**
   * 设置自定义ID
   * 用于实现单点追查功能，即进行用户级和播放会话级的全链路问题定位和追踪。
   *
   * 初始化/登录成功/切换登录后调用，以更新自定义ID。
   *
   * 如何使用自定义ID https://www.volcengine.com/docs/4/171486
   *
   * @param arg
   */
  func setUserUniqueId(arg: [String : Any?]) {
    let userUniqueId = arg["UserUniqueId"] as? String
    if userUniqueId != nil {
      TTSDKManager.setCurrentUserUniqueID(userUniqueId)
    }
  }

  /**
   * 清除自定义ID
   *
   * 退出登录后调用，以更新自定义ID。
   */
  func clearUserUniqueId() {
    TTSDKManager.clearUserUniqueID()
  }
}
