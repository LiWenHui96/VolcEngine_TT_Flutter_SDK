import 'flutter_volcengine_video_platform_interface.dart';

class FlutterVolcengineVideo {
  Future<String?> getPlatformVersion() {
    return FlutterVolcengineVideoPlatform.instance.getPlatformVersion();
  }
}
