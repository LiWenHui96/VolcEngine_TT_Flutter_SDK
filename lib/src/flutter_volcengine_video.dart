part of flutter_volcengine_video;

class FlutterVolcengineVideo {
  Future<String?> getPlatformVersion() {
    return FlutterVolcengineVideoPlatform.instance.getPlatformVersion();
  }
}
