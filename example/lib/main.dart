import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_volc_engine_tt/flutter_volc_engine_tt.dart';

import 'page_video.dart';

void main() {
  runApp(const MyApp());
}

/// Program entry
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      title: 'Video View Example',
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: const <Locale>[Locale('zh', 'CN')],
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Home
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('火山云视频点播')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildButton('初始化 VodSDK', onPressed: _initVodSDK),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, {VoidCallback? onPressed}) {
    final Widget child = ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: child,
    );
  }

  /// 初始化 VodSDK
  Future<void> _initVodSDK() async {
    final LicenseStatus status = await FlutterVolcEngineTT.instance.initVodSDK(
      appId: '595816',
      licenseName: 'vod',
      appName: 'volcengine_ttsdk',
      appVersion: '0.0.1',
      appChannel: 'dev',
      isDebug: kDebugMode,
    );
    debugPrint('LicenseStatus: $status');
  }
}
