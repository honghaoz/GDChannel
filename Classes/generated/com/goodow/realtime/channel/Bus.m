//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/Bus.java
//
//  Created by retechretech.
//

#include "com/goodow/realtime/channel/Bus.h"
#include "com/goodow/realtime/channel/BusHook.h"
#include "com/goodow/realtime/channel/State.h"
#include "com/goodow/realtime/core/Handler.h"
#include "com/goodow/realtime/core/HandlerRegistration.h"


@implementation GDCBus

static NSString * GDCBus_LOCAL_ = @"@";
static NSString * GDCBus_LOCAL_ON_OPEN_ = @"@goodow.bus.onOpen";
static NSString * GDCBus_LOCAL_ON_CLOSE_ = @"@goodow.bus.onClose";
static NSString * GDCBus_LOCAL_ON_ERROR_ = @"@goodow.bus.onError";

+ (NSString *)LOCAL {
  return GDCBus_LOCAL_;
}

+ (NSString *)LOCAL_ON_OPEN {
  return GDCBus_LOCAL_ON_OPEN_;
}

+ (NSString *)LOCAL_ON_CLOSE {
  return GDCBus_LOCAL_ON_CLOSE_;
}

+ (NSString *)LOCAL_ON_ERROR {
  return GDCBus_LOCAL_ON_ERROR_;
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "close", NULL, "V", 0x401, NULL },
    { "getReadyState", NULL, "Lcom.goodow.realtime.channel.State;", 0x401, NULL },
    { "publish:message:", "publish", "Lcom.goodow.realtime.channel.Bus;", 0x401, NULL },
    { "registerHandler:handler:", "registerHandler", "Lcom.goodow.realtime.core.HandlerRegistration;", 0x401, NULL },
    { "send:message:replyHandler:", "send", "Lcom.goodow.realtime.channel.Bus;", 0x401, NULL },
    { "setHookWithGDCBusHook:", "setHook", "Lcom.goodow.realtime.channel.Bus;", 0x401, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "LOCAL_", NULL, 0x19, "Ljava.lang.String;" },
    { "LOCAL_ON_OPEN_", NULL, 0x19, "Ljava.lang.String;" },
    { "LOCAL_ON_CLOSE_", NULL, 0x19, "Ljava.lang.String;" },
    { "LOCAL_ON_ERROR_", NULL, 0x19, "Ljava.lang.String;" },
  };
  static J2ObjcClassInfo _GDCBus = { "Bus", "com.goodow.realtime.channel", NULL, 0x201, 6, methods, 4, fields, 0, NULL};
  return &_GDCBus;
}

@end