#import "FlutterP2pPlugin.h"
#import <flutter_p2p/flutter_p2p-Swift.h>

@implementation FlutterP2pPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterP2pPlugin registerWithRegistrar:registrar];
}
@end
