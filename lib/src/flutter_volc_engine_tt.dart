part of flutter_volc_engine_tt;

class FlutterVolcEngineTT {
  Future<String?> getPlatformVersion() {
    return FlutterVolcEngineTTPlatform.instance.getPlatformVersion();
  }
}
