/// @Describe: License鉴权状态
///
/// @Author: LiWeNHuI
/// @Date: 2024/4/17

part of flutter_volc_engine_tt_enums;

enum LicenseStatus {
  /// 无任何状态
  NONE(-1),

  /// 1. License 文件非法，或被篡改
  /// 2. 未添加 License，或路径设置错误
  INVALID(0),

  /// License 鉴权通过
  OK(1),

  /// License 已过期
  EXPIRED(2),

  /// 应用包名与购买 License 填写的包名不符
  ERROR_PARAM_PACKAGE_NAME(401),

  /// 1. License 中不包含该增值服务
  /// 2. 增值服务名错误
  ERROR_PARAM_FEATURE_NAME(402),

  /// 点播 SDK 枚举传递错误
  ERROR_PARAM_MODULE_NAME(403);

  const LicenseStatus(this.code);

  /// 状态码
  final int code;

  /// {@template flutter.volc.engine.tt.platform.isInitialized}
  /// 鉴权通过
  /// 指示视频是否已加载并准备播放
  /// {@endtemplate}
  bool get isInitialized => this == LicenseStatus.OK;
}
