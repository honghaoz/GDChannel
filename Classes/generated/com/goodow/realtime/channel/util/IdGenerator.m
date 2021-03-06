//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/util/IdGenerator.java
//
//  Created by retechretech.
//

#include "IOSPrimitiveArray.h"
#include "com/goodow/realtime/channel/util/IdGenerator.h"
#include "java/lang/StringBuilder.h"
#include "java/util/Random.h"

BOOL ComGoodowRealtimeChannelUtilIdGenerator_initialized = NO;

@implementation ComGoodowRealtimeChannelUtilIdGenerator

IOSCharArray * ComGoodowRealtimeChannelUtilIdGenerator_WEB64_ALPHABET_;
IOSCharArray * ComGoodowRealtimeChannelUtilIdGenerator_NUMBERS_;

- (id)init {
  return [self initComGoodowRealtimeChannelUtilIdGeneratorWithJavaUtilRandom:[[JavaUtilRandom alloc] init]];
}

- (id)initComGoodowRealtimeChannelUtilIdGeneratorWithJavaUtilRandom:(JavaUtilRandom *)random {
  if (self = [super init]) {
    self->random_ = random;
  }
  return self;
}

- (id)initWithJavaUtilRandom:(JavaUtilRandom *)random {
  return [self initComGoodowRealtimeChannelUtilIdGeneratorWithJavaUtilRandom:random];
}

- (NSString *)nextWithInt:(int)length {
  JavaLangStringBuilder *result = [[JavaLangStringBuilder alloc] initWithInt:length];
  for (int i = 0; i < length; i++) {
    (void) [result appendWithChar:IOSCharArray_Get(nil_chk(ComGoodowRealtimeChannelUtilIdGenerator_WEB64_ALPHABET_), [((JavaUtilRandom *) nil_chk(random_)) nextIntWithInt:64])];
  }
  return [result description];
}

- (NSString *)nextNumbersWithInt:(int)length {
  JavaLangStringBuilder *result = [[JavaLangStringBuilder alloc] initWithInt:length];
  for (int i = 0; i < length; i++) {
    (void) [result appendWithChar:IOSCharArray_Get(nil_chk(ComGoodowRealtimeChannelUtilIdGenerator_NUMBERS_), [((JavaUtilRandom *) nil_chk(random_)) nextIntWithInt:10])];
  }
  return [result description];
}

+ (void)initialize {
  if (self == [ComGoodowRealtimeChannelUtilIdGenerator class]) {
    ComGoodowRealtimeChannelUtilIdGenerator_WEB64_ALPHABET_ = [@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_" toCharArray];
    ComGoodowRealtimeChannelUtilIdGenerator_NUMBERS_ = [@"0123456789" toCharArray];
    ComGoodowRealtimeChannelUtilIdGenerator_initialized = YES;
  }
}

- (void)copyAllFieldsTo:(ComGoodowRealtimeChannelUtilIdGenerator *)other {
  [super copyAllFieldsTo:other];
  other->random_ = random_;
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "init", "IdGenerator", NULL, 0x1, NULL },
    { "initWithJavaUtilRandom:", "IdGenerator", NULL, 0x1, NULL },
    { "nextWithInt:", "next", "Ljava.lang.String;", 0x1, NULL },
    { "nextNumbersWithInt:", "nextNumbers", "Ljava.lang.String;", 0x1, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "WEB64_ALPHABET_", NULL, 0x18, "[C", &ComGoodowRealtimeChannelUtilIdGenerator_WEB64_ALPHABET_,  },
    { "NUMBERS_", NULL, 0x18, "[C", &ComGoodowRealtimeChannelUtilIdGenerator_NUMBERS_,  },
    { "random_", NULL, 0x12, "Ljava.util.Random;", NULL,  },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelUtilIdGenerator = { "IdGenerator", "com.goodow.realtime.channel.util", NULL, 0x1, 4, methods, 3, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelUtilIdGenerator;
}

@end
