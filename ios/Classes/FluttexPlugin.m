#import "FluttexPlugin.h"
#if __has_include(<fluttex/fluttex-Swift.h>)
#import <fluttex/fluttex-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fluttex-Swift.h"
#endif

@implementation FluttexPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFluttexPlugin registerWithRegistrar:registrar];
}
@end
