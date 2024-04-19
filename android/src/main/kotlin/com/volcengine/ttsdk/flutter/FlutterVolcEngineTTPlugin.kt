package com.volcengine.ttsdk.flutter

import android.content.Context
import android.text.TextUtils
import com.pandora.common.applog.AppLogWrapper
import com.pandora.common.env.Env
import com.pandora.common.env.config.Config
import com.pandora.common.env.config.VodConfig
import com.pandora.ttlicense2.C
import com.pandora.ttlicense2.LicenseManager
import com.pandora.vod.VodSDK
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.File

/** FlutterVolcEngineTTPlugin */
class FlutterVolcEngineTTPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding
  private lateinit var channel: MethodChannel
  private lateinit var mContext: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.flutterPluginBinding = flutterPluginBinding

    channel = MethodChannel(flutterPluginBinding.binaryMessenger, CHANNEL_NAME)
    channel.setMethodCallHandler(this)

    mContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "initVodSDK" -> result.success(initVodSDK(call = call))
      "setUserUniqueId" -> setUserUniqueId(call = call)
      "clearUserUniqueId" -> clearUserUniqueId()
      else -> result.notImplemented()
    }
  }

  /**
   * 初始化 并 查询 VodSDK 鉴权状态
   *
   * @param call
   * @return
   */
  private fun initVodSDK(call: MethodCall): Int {
    // 是否开启日志调试
    val isDebug: Boolean = call.argument<Boolean>("isDebug") ?: false
    if (isDebug) VodSDK.openAllVodLog()

    // 设置缓存信息
    // 默认大小为 300MB
    val defaultMaxCacheSize = 300 * 1024 * 1024
    val cacheDirPath = call.argument<String>("CacheDirPath") ?: ""
    val maxCacheSize = call.argument<Int>("MaxCacheSize") ?: defaultMaxCacheSize
    val videoCacheDir = File(mContext.cacheDir, cacheDirPath)
    if (!videoCacheDir.exists()) videoCacheDir.mkdirs()
    val vodBuilder = VodConfig.Builder(mContext)
      .setCacheDirPath(videoCacheDir.absolutePath)
      .setMaxCacheSize(maxCacheSize)

    // 初始化信息
    val appId = call.argument<String>("AppID") ?: ""
    val appName = call.argument<String>("AppName") ?: ""
    val appVersion = call.argument<String>("AppVersion") ?: ""
    val appChannel = call.argument<String>("AppChannel") ?: ""
    val licenseUri = flutterPluginBinding.flutterAssets.getAssetFilePathByName(
      call.argument<String>("License") ?: ""
    )

    // 初始化
    Env.init(
      Config.Builder()
        .setApplicationContext(mContext)
        .setAppID(appId)
        .setAppName(appName)
        .setAppVersion(appVersion)
        .setAppChannel(appChannel)
        .setLicenseUri("assets:///$licenseUri")
        .setVodConfig(vodBuilder.build())
        .build()
    )

    // 设置自定义ID
    setUserUniqueId(call = call)

    return LicenseManager.getInstance().checkSDKAuth(C.SDK.SDK_VOD_PLAY)
  }

  /**
   * 设置自定义ID
   * 用于实现单点追查功能，即进行用户级和播放会话级的全链路问题定位和追踪。
   *
   * 初始化/登录成功/切换登录后调用，以更新自定义ID。
   *
   * 如何使用自定义ID https://www.volcengine.com/docs/4/161480
   *
   * @param call
   */
  private fun setUserUniqueId(call: MethodCall) {
    val userUniqueId = call.argument<String>("UserUniqueId") ?: ""
    val appLogWrapper = AppLogWrapper.getAppLogInstance()
    if (appLogWrapper != null && !TextUtils.isEmpty(userUniqueId)) {
      appLogWrapper.setUserUniqueID(userUniqueId)
    }
  }

  /**
   * 清除自定义ID
   *
   * 退出登录后调用，以更新自定义ID。
   */
  private fun clearUserUniqueId() {
    val appLogWrapper = AppLogWrapper.getAppLogInstance()
    appLogWrapper?.setUserUniqueID(null)
  }

  companion object {
    val TAG: String = FlutterVolcEngineTTPlugin::class.java.name

    const val CHANNEL_NAME = "flutter_volc_engine_tt"
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
