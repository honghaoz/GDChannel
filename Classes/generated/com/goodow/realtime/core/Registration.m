//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/core/Registration.java
//
//  Created by retechretech.
//

#include "IOSClass.h"
#include "com/goodow/realtime/core/Registration.h"
#include "com/google/gwt/core/client/js/JsType.h"

BOOL ComGoodowRealtimeCoreRegistration_initialized = NO;

id<ComGoodowRealtimeCoreRegistration> ComGoodowRealtimeCoreRegistration_EMPTY_;

@implementation ComGoodowRealtimeCoreRegistration

+ (void)initialize {
  if (self == [ComGoodowRealtimeCoreRegistration class]) {
    ComGoodowRealtimeCoreRegistration_EMPTY_ = [[ComGoodowRealtimeCoreRegistration_$1 alloc] init];
    ComGoodowRealtimeCoreRegistration_initialized = YES;
  }
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "unregister", NULL, "V", 0x401, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "EMPTY_", NULL, 0x19, "Lcom.goodow.realtime.core.Registration;", &ComGoodowRealtimeCoreRegistration_EMPTY_,  },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeCoreRegistration = { "Registration", "com.goodow.realtime.core", NULL, 0x201, 1, methods, 1, fields, 0, NULL};
  return &_ComGoodowRealtimeCoreRegistration;
}

@end

@implementation ComGoodowRealtimeCoreRegistration_$1

- (void)unregister {
}

- (id)init {
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "unregister", NULL, "V", 0x1, NULL },
    { "init", NULL, NULL, 0x0, NULL },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeCoreRegistration_$1 = { "$1", "com.goodow.realtime.core", "Registration", 0x8000, 2, methods, 0, NULL, 0, NULL};
  return &_ComGoodowRealtimeCoreRegistration_$1;
}

@end
