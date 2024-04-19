#import "FlutterVolcEngineTTPlugin.h"
#if __has_include(<flutter_volc_engine_tt/flutter_volc_engine_tt-Swift.h>)
#import <flutter_volc_engine_tt/flutter_volc_engine_tt-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_volc_engine_tt-Swift.h"
#endif

@implementation FlutterVolcEngineTTPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterVolcEngineTTPlugin registerWithRegistrar:registrar];
}
@end
