//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/ReplyFailure.java
//
//  Created by retechretech.
//

#ifndef _ComGoodowRealtimeChannelReplyFailure_H_
#define _ComGoodowRealtimeChannelReplyFailure_H_

#import "JreEmulation.h"
#include "java/lang/Enum.h"

typedef enum {
  ComGoodowRealtimeChannelReplyFailure_TIMEOUT = 0,
  ComGoodowRealtimeChannelReplyFailure_NO_HANDLERS = 1,
  ComGoodowRealtimeChannelReplyFailure_RECIPIENT_FAILURE = 2,
} ComGoodowRealtimeChannelReplyFailure;

@interface ComGoodowRealtimeChannelReplyFailureEnum : JavaLangEnum < NSCopying > {
}
+ (IOSObjectArray *)values;
+ (ComGoodowRealtimeChannelReplyFailureEnum *)valueOfWithNSString:(NSString *)name;
- (id)copyWithZone:(NSZone *)zone;

+ (ComGoodowRealtimeChannelReplyFailureEnum *)fromIntWithInt:(int)i;

- (int)toInt;

- (id)initWithNSString:(NSString *)__name withInt:(int)__ordinal;
@end

FOUNDATION_EXPORT BOOL ComGoodowRealtimeChannelReplyFailureEnum_initialized;
J2OBJC_STATIC_INIT(ComGoodowRealtimeChannelReplyFailureEnum)

FOUNDATION_EXPORT ComGoodowRealtimeChannelReplyFailureEnum *ComGoodowRealtimeChannelReplyFailureEnum_values[];

#define ComGoodowRealtimeChannelReplyFailureEnum_TIMEOUT ComGoodowRealtimeChannelReplyFailureEnum_values[ComGoodowRealtimeChannelReplyFailure_TIMEOUT]
J2OBJC_STATIC_FIELD_GETTER(ComGoodowRealtimeChannelReplyFailureEnum, TIMEOUT, ComGoodowRealtimeChannelReplyFailureEnum *)

#define ComGoodowRealtimeChannelReplyFailureEnum_NO_HANDLERS ComGoodowRealtimeChannelReplyFailureEnum_values[ComGoodowRealtimeChannelReplyFailure_NO_HANDLERS]
J2OBJC_STATIC_FIELD_GETTER(ComGoodowRealtimeChannelReplyFailureEnum, NO_HANDLERS, ComGoodowRealtimeChannelReplyFailureEnum *)

#define ComGoodowRealtimeChannelReplyFailureEnum_RECIPIENT_FAILURE ComGoodowRealtimeChannelReplyFailureEnum_values[ComGoodowRealtimeChannelReplyFailure_RECIPIENT_FAILURE]
J2OBJC_STATIC_FIELD_GETTER(ComGoodowRealtimeChannelReplyFailureEnum, RECIPIENT_FAILURE, ComGoodowRealtimeChannelReplyFailureEnum *)

#endif // _ComGoodowRealtimeChannelReplyFailure_H_
