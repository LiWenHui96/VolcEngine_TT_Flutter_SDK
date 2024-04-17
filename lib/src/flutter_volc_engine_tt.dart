part of flutter_volc_engine_tt;

class FlutterVolcEngineTt {
  Future<String?> getPlatformVersion() {
    return FlutterVolcEngineTtPlatform.instance.getPlatformVersion();
  }
}
