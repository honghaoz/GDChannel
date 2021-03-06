//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/impl/ReliableSubscribeBus.java
//
//  Created by retechretech.
//

#include "IOSClass.h"
#include "com/goodow/realtime/channel/Bus.h"
#include "com/goodow/realtime/channel/BusHook.h"
#include "com/goodow/realtime/channel/Message.h"
#include "com/goodow/realtime/channel/impl/MessageImpl.h"
#include "com/goodow/realtime/channel/impl/ReliableSubscribeBus.h"
#include "com/goodow/realtime/core/Platform.h"
#include "com/goodow/realtime/core/Scheduler.h"
#include "com/goodow/realtime/json/Json.h"
#include "com/goodow/realtime/json/JsonArray.h"
#include "com/goodow/realtime/json/JsonObject.h"
#include "java/lang/Math.h"
#include "java/lang/Void.h"
#include "java/util/logging/Level.h"
#include "java/util/logging/Logger.h"

BOOL ComGoodowRealtimeChannelImplReliableSubscribeBus_initialized = NO;

@implementation ComGoodowRealtimeChannelImplReliableSubscribeBus

NSString * ComGoodowRealtimeChannelImplReliableSubscribeBus_SEQUENCE_NUMBER_ = @"sequence_number_key";
NSString * ComGoodowRealtimeChannelImplReliableSubscribeBus_PUBLISH_CHANNEL_ = @"publish_channel";
NSString * ComGoodowRealtimeChannelImplReliableSubscribeBus_ACKNOWLEDGE_DELAY_MILLIS_ = @"acknowledgeDelayMillis";
JavaUtilLoggingLogger * ComGoodowRealtimeChannelImplReliableSubscribeBus_log_;

- (id)initWithComGoodowRealtimeChannelBus:(id<ComGoodowRealtimeChannelBus>)delegate
      withComGoodowRealtimeJsonJsonObject:(id<ComGoodowRealtimeJsonJsonObject>)options {
  if (self = [super initWithComGoodowRealtimeChannelBus:delegate]) {
    sequenceNumberKey_ = options == nil || ![options hasWithNSString:ComGoodowRealtimeChannelImplReliableSubscribeBus_SEQUENCE_NUMBER_] ? @"v" : [options getStringWithNSString:ComGoodowRealtimeChannelImplReliableSubscribeBus_SEQUENCE_NUMBER_];
    publishChannel_ = options == nil || ![options hasWithNSString:ComGoodowRealtimeChannelImplReliableSubscribeBus_PUBLISH_CHANNEL_] ? @"realtime/store" : [options getStringWithNSString:ComGoodowRealtimeChannelImplReliableSubscribeBus_PUBLISH_CHANNEL_];
    acknowledgeDelayMillis_ = options == nil || ![options hasWithNSString:ComGoodowRealtimeChannelImplReliableSubscribeBus_ACKNOWLEDGE_DELAY_MILLIS_] ? 3 * 1000 : J2ObjCFpToInt([options getNumberWithNSString:ComGoodowRealtimeChannelImplReliableSubscribeBus_ACKNOWLEDGE_DELAY_MILLIS_]);
    pendings_ = [ComGoodowRealtimeJsonJson createObject];
    currentSequences_ = [ComGoodowRealtimeJsonJson createObject];
    knownHeadSequences_ = [ComGoodowRealtimeJsonJson createObject];
    acknowledgeScheduled_ = [ComGoodowRealtimeJsonJson createObject];
    acknowledgeNumbers_ = [ComGoodowRealtimeJsonJson createObject];
    (void) [((id<ComGoodowRealtimeChannelBus>) nil_chk(delegate)) setHookWithComGoodowRealtimeChannelBusHook:[[ComGoodowRealtimeChannelImplReliableSubscribeBus_$1 alloc] initWithComGoodowRealtimeChannelImplReliableSubscribeBus:self]];
  }
  return self;
}

- (void)close {
  [super close];
  (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(pendings_)) clear];
  (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(currentSequences_)) clear];
  (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(knownHeadSequences_)) clear];
  (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(acknowledgeScheduled_)) clear];
  (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(acknowledgeNumbers_)) clear];
}

- (void)synchronizeSequenceNumberWithNSString:(NSString *)topic
                                   withDouble:(double)initialSequenceNumber {
  NSAssert(![((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(currentSequences_)) hasWithNSString:topic] && ![((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(knownHeadSequences_)) hasWithNSString:topic] && ![((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(pendings_)) hasWithNSString:topic], @"/Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/impl/ReliableSubscribeBus.java:105 condition failed: assert !currentSequences.has(topic) && !knownHeadSequences.has(topic)\n        && !pendings.has(topic);");
  [self initSequenceNumberWithNSString:topic withDouble:initialSequenceNumber];
  [self catchupWithNSString:topic withDouble:initialSequenceNumber];
}

- (void)catchupWithNSString:(NSString *)topic
                 withDouble:(double)currentSequence {
  NSString *id_ = [((NSString *) nil_chk(topic)) substring:((int) [((NSString *) nil_chk(publishChannel_)) length]) + 1];
  id_ = [id_ substring:0 endIndex:[((NSString *) nil_chk(id_)) lastIndexOfString:@"/_watch"]];
  (void) [((id<ComGoodowRealtimeChannelBus>) nil_chk(delegate_)) sendWithNSString:[NSString stringWithFormat:@"%@/_ops", publishChannel_] withId:[((id<ComGoodowRealtimeJsonJsonObject>) nil_chk([((id<ComGoodowRealtimeJsonJsonObject>) nil_chk([ComGoodowRealtimeJsonJson createObject])) setWithNSString:@"id" withId:id_])) setWithNSString:@"from" withDouble:currentSequence + 1] withComGoodowRealtimeCoreHandler:[[ComGoodowRealtimeChannelImplReliableSubscribeBus_$2 alloc] initWithComGoodowRealtimeChannelImplReliableSubscribeBus:self withNSString:topic]];
}

- (double)getSequenceNumberWithNSString:(NSString *)topic
                                 withId:(id)body {
  return [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(((id<ComGoodowRealtimeJsonJsonObject>) check_protocol_cast(body, @protocol(ComGoodowRealtimeJsonJsonObject))))) getNumberWithNSString:sequenceNumberKey_];
}

- (BOOL)needProcessWithNSString:(NSString *)topic {
  return [((NSString *) nil_chk(topic)) hasPrefix:[NSString stringWithFormat:@"%@/", publishChannel_]] && [topic hasSuffix:@"/_watch"] && ![topic contains:@"/_presence/"];
}

- (BOOL)onReceiveMessageWithComGoodowRealtimeChannelMessage:(id<ComGoodowRealtimeChannelMessage>)message {
  NSString *topic = [((id<ComGoodowRealtimeChannelMessage>) nil_chk(message)) topic];
  id body = [message body];
  if (![self needProcessWithNSString:topic]) {
    return YES;
  }
  double sequence = [self getSequenceNumberWithNSString:topic withId:body];
  if (![((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(currentSequences_)) hasWithNSString:topic]) {
    [self initSequenceNumberWithNSString:topic withDouble:sequence];
    return YES;
  }
  double currentSequence = [currentSequences_ getNumberWithNSString:topic];
  if (sequence <= currentSequence) {
    [((JavaUtilLoggingLogger *) nil_chk(ComGoodowRealtimeChannelImplReliableSubscribeBus_log_)) logWithJavaUtilLoggingLevel:JavaUtilLoggingLevel_get_CONFIG_() withNSString:[NSString stringWithFormat:@"Old dup at sequence %f, current is now %f", sequence, currentSequence]];
    return NO;
  }
  id<ComGoodowRealtimeJsonJsonObject> pending = [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(pendings_)) getObjectWithNSString:topic];
  id<ComGoodowRealtimeChannelMessage> existing = [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(pending)) getWithNSString:[NSString stringWithFormat:@"%f", sequence]];
  if (existing != nil) {
    NSAssert(sequence > currentSequence + 1, @"should not have pending data");
    [((JavaUtilLoggingLogger *) nil_chk(ComGoodowRealtimeChannelImplReliableSubscribeBus_log_)) logWithJavaUtilLoggingLevel:JavaUtilLoggingLevel_get_CONFIG_() withNSString:[NSString stringWithFormat:@"Dup message: %@", message]];
    return NO;
  }
  (void) [knownHeadSequences_ setWithNSString:topic withDouble:[JavaLangMath maxWithDouble:[((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(knownHeadSequences_)) getNumberWithNSString:topic] withDouble:sequence]];
  if (sequence > currentSequence + 1) {
    (void) [pending setWithNSString:[NSString stringWithFormat:@"%f", sequence] withId:message];
    [((JavaUtilLoggingLogger *) nil_chk(ComGoodowRealtimeChannelImplReliableSubscribeBus_log_)) logWithJavaUtilLoggingLevel:JavaUtilLoggingLevel_get_CONFIG_() withNSString:[NSString stringWithFormat:@"Missed message, current sequence=%f incoming sequence=%f", currentSequence, sequence]];
    [self scheduleAcknowledgmentWithNSString:topic];
    return NO;
  }
  NSAssert(sequence == currentSequence + 1, @"other cases should have been caught");
  NSString *next;
  id<ComGoodowRealtimeJsonJsonArray> messages = [ComGoodowRealtimeJsonJson createArray];
  while (YES) {
    (void) [((id<ComGoodowRealtimeJsonJsonArray>) nil_chk(messages)) pushWithId:message];
    (void) [currentSequences_ setWithNSString:topic withDouble:++currentSequence];
    next = [NSString stringWithFormat:@"%f", currentSequence + 1];
    message = [pending getWithNSString:next];
    if (message != nil) {
      (void) [pending removeWithNSString:next];
    }
    else {
      break;
    }
  }
  [self scheduleMessagesWithComGoodowRealtimeJsonJsonArray:messages];
  NSAssert(![pending hasWithNSString:next], @"/Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/impl/ReliableSubscribeBus.java:195 condition failed: assert !pending.has(next);");
  return NO;
}

- (void)initSequenceNumberWithNSString:(NSString *)topic
                            withDouble:(double)initialSequenceNumber {
  (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(currentSequences_)) setWithNSString:topic withDouble:initialSequenceNumber];
  (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(knownHeadSequences_)) setWithNSString:topic withDouble:initialSequenceNumber];
  (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(pendings_)) setWithNSString:topic withId:[ComGoodowRealtimeJsonJson createObject]];
}

- (void)scheduleAcknowledgmentWithNSString:(NSString *)topic {
  if (![((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(acknowledgeScheduled_)) hasWithNSString:topic]) {
    (void) [acknowledgeScheduled_ setWithNSString:topic withBoolean:YES];
    [((id<ComGoodowRealtimeCoreScheduler>) nil_chk([ComGoodowRealtimeCorePlatform scheduler])) scheduleDelayWithInt:acknowledgeDelayMillis_ withComGoodowRealtimeCoreHandler:[[ComGoodowRealtimeChannelImplReliableSubscribeBus_$3 alloc] initWithComGoodowRealtimeChannelImplReliableSubscribeBus:self withNSString:topic]];
  }
}

- (void)scheduleMessagesWithComGoodowRealtimeJsonJsonArray:(id<ComGoodowRealtimeJsonJsonArray>)messages {
  [((id<ComGoodowRealtimeCoreScheduler>) nil_chk([ComGoodowRealtimeCorePlatform scheduler])) scheduleDeferredWithComGoodowRealtimeCoreHandler:[[ComGoodowRealtimeChannelImplReliableSubscribeBus_$4 alloc] initWithComGoodowRealtimeChannelImplReliableSubscribeBus:self withComGoodowRealtimeJsonJsonArray:messages]];
}

+ (void)initialize {
  if (self == [ComGoodowRealtimeChannelImplReliableSubscribeBus class]) {
    ComGoodowRealtimeChannelImplReliableSubscribeBus_log_ = [JavaUtilLoggingLogger getLoggerWithNSString:[[IOSClass classWithClass:[ComGoodowRealtimeChannelImplReliableSubscribeBus class]] getName]];
    ComGoodowRealtimeChannelImplReliableSubscribeBus_initialized = YES;
  }
}

- (void)copyAllFieldsTo:(ComGoodowRealtimeChannelImplReliableSubscribeBus *)other {
  [super copyAllFieldsTo:other];
  other->acknowledgeDelayMillis_ = acknowledgeDelayMillis_;
  other->acknowledgeNumbers_ = acknowledgeNumbers_;
  other->acknowledgeScheduled_ = acknowledgeScheduled_;
  other->currentSequences_ = currentSequences_;
  other->knownHeadSequences_ = knownHeadSequences_;
  other->pendings_ = pendings_;
  other->publishChannel_ = publishChannel_;
  other->sequenceNumberKey_ = sequenceNumberKey_;
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "initWithComGoodowRealtimeChannelBus:withComGoodowRealtimeJsonJsonObject:", "ReliableSubscribeBus", NULL, 0x1, NULL },
    { "close", NULL, "V", 0x1, NULL },
    { "synchronizeSequenceNumberWithNSString:withDouble:", "synchronizeSequenceNumber", "V", 0x1, NULL },
    { "catchupWithNSString:withDouble:", "catchup", "V", 0x4, NULL },
    { "getSequenceNumberWithNSString:withId:", "getSequenceNumber", "D", 0x4, NULL },
    { "needProcessWithNSString:", "needProcess", "Z", 0x4, NULL },
    { "onReceiveMessageWithComGoodowRealtimeChannelMessage:", "onReceiveMessage", "Z", 0x4, NULL },
    { "initSequenceNumberWithNSString:withDouble:", "initSequenceNumber", "V", 0x2, NULL },
    { "scheduleAcknowledgmentWithNSString:", "scheduleAcknowledgment", "V", 0x2, NULL },
    { "scheduleMessagesWithComGoodowRealtimeJsonJsonArray:", "scheduleMessages", "V", 0x2, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "SEQUENCE_NUMBER_", NULL, 0x19, "Ljava.lang.String;", &ComGoodowRealtimeChannelImplReliableSubscribeBus_SEQUENCE_NUMBER_,  },
    { "PUBLISH_CHANNEL_", NULL, 0x19, "Ljava.lang.String;", &ComGoodowRealtimeChannelImplReliableSubscribeBus_PUBLISH_CHANNEL_,  },
    { "ACKNOWLEDGE_DELAY_MILLIS_", NULL, 0x19, "Ljava.lang.String;", &ComGoodowRealtimeChannelImplReliableSubscribeBus_ACKNOWLEDGE_DELAY_MILLIS_,  },
    { "log_", NULL, 0x1a, "Ljava.util.logging.Logger;", &ComGoodowRealtimeChannelImplReliableSubscribeBus_log_,  },
    { "sequenceNumberKey_", NULL, 0x12, "Ljava.lang.String;", NULL,  },
    { "publishChannel_", NULL, 0x12, "Ljava.lang.String;", NULL,  },
    { "acknowledgeDelayMillis_", NULL, 0x12, "I", NULL,  },
    { "pendings_", NULL, 0x12, "Lcom.goodow.realtime.json.JsonObject;", NULL,  },
    { "currentSequences_", NULL, 0x12, "Lcom.goodow.realtime.json.JsonObject;", NULL,  },
    { "knownHeadSequences_", NULL, 0x12, "Lcom.goodow.realtime.json.JsonObject;", NULL,  },
    { "acknowledgeScheduled_", NULL, 0x12, "Lcom.goodow.realtime.json.JsonObject;", NULL,  },
    { "acknowledgeNumbers_", NULL, 0x12, "Lcom.goodow.realtime.json.JsonObject;", NULL,  },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplReliableSubscribeBus = { "ReliableSubscribeBus", "com.goodow.realtime.channel.impl", NULL, 0x1, 10, methods, 12, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplReliableSubscribeBus;
}

@end

@implementation ComGoodowRealtimeChannelImplReliableSubscribeBus_$1

- (BOOL)handleReceiveMessageWithComGoodowRealtimeChannelMessage:(id<ComGoodowRealtimeChannelMessage>)message {
  if (this$0_->hook_ != nil && ![this$0_->hook_ handleReceiveMessageWithComGoodowRealtimeChannelMessage:message]) {
    return NO;
  }
  return [this$0_ onReceiveMessageWithComGoodowRealtimeChannelMessage:message];
}

- (BOOL)handleUnsubscribeWithNSString:(NSString *)topic {
  if ([this$0_ needProcessWithNSString:topic]) {
    (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->pendings_)) removeWithNSString:topic];
    (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->currentSequences_)) removeWithNSString:topic];
    (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->knownHeadSequences_)) removeWithNSString:topic];
    (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->acknowledgeScheduled_)) removeWithNSString:topic];
    (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->acknowledgeNumbers_)) removeWithNSString:topic];
  }
  return [super handleUnsubscribeWithNSString:topic];
}

- (id<ComGoodowRealtimeChannelBusHook>)delegate {
  return this$0_->hook_;
}

- (id)initWithComGoodowRealtimeChannelImplReliableSubscribeBus:(ComGoodowRealtimeChannelImplReliableSubscribeBus *)outer$ {
  this$0_ = outer$;
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "handleReceiveMessageWithComGoodowRealtimeChannelMessage:", "handleReceiveMessage", "Z", 0x1, NULL },
    { "handleUnsubscribeWithNSString:", "handleUnsubscribe", "Z", 0x1, NULL },
    { "delegate", NULL, "Lcom.goodow.realtime.channel.BusHook;", 0x4, NULL },
    { "initWithComGoodowRealtimeChannelImplReliableSubscribeBus:", "init", NULL, 0x0, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "this$0_", NULL, 0x1012, "Lcom.goodow.realtime.channel.impl.ReliableSubscribeBus;", NULL,  },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplReliableSubscribeBus_$1 = { "$1", "com.goodow.realtime.channel.impl", "ReliableSubscribeBus", 0x8000, 4, methods, 1, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplReliableSubscribeBus_$1;
}

@end

@implementation ComGoodowRealtimeChannelImplReliableSubscribeBus_$2

- (void)handleWithId:(id<ComGoodowRealtimeChannelMessage>)message {
  NSString *replyTopic = [((id<ComGoodowRealtimeChannelMessage>) nil_chk(message)) replyTopic];
  [((id<ComGoodowRealtimeJsonJsonArray>) nil_chk([message body])) forEachWithComGoodowRealtimeJsonJsonArray_ListIterator:[[ComGoodowRealtimeChannelImplReliableSubscribeBus_$2_$1 alloc] initWithComGoodowRealtimeChannelImplReliableSubscribeBus_$2:self withNSString:replyTopic]];
}

- (id)initWithComGoodowRealtimeChannelImplReliableSubscribeBus:(ComGoodowRealtimeChannelImplReliableSubscribeBus *)outer$
                                                  withNSString:(NSString *)capture$0 {
  this$0_ = outer$;
  val$topic_ = capture$0;
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "handleWithComGoodowRealtimeChannelMessage:", "handle", "V", 0x1, NULL },
    { "initWithComGoodowRealtimeChannelImplReliableSubscribeBus:withNSString:", "init", NULL, 0x0, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "this$0_", NULL, 0x1012, "Lcom.goodow.realtime.channel.impl.ReliableSubscribeBus;", NULL,  },
    { "val$topic_", NULL, 0x1012, "Ljava.lang.String;", NULL,  },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplReliableSubscribeBus_$2 = { "$2", "com.goodow.realtime.channel.impl", "ReliableSubscribeBus", 0x8000, 2, methods, 2, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplReliableSubscribeBus_$2;
}

@end

@implementation ComGoodowRealtimeChannelImplReliableSubscribeBus_$2_$1

- (void)callWithInt:(int)index
             withId:(id)value {
  [this$0_->this$0_ onReceiveMessageWithComGoodowRealtimeChannelMessage:[[ComGoodowRealtimeChannelImplMessageImpl alloc] initWithBoolean:NO withBoolean:NO withComGoodowRealtimeChannelBus:this$0_->this$0_ withNSString:this$0_->val$topic_ withNSString:val$replyTopic_ withId:value]];
}

- (id)initWithComGoodowRealtimeChannelImplReliableSubscribeBus_$2:(ComGoodowRealtimeChannelImplReliableSubscribeBus_$2 *)outer$
                                                     withNSString:(NSString *)capture$0 {
  this$0_ = outer$;
  val$replyTopic_ = capture$0;
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "callWithInt:withId:", "call", "V", 0x1, NULL },
    { "initWithComGoodowRealtimeChannelImplReliableSubscribeBus_$2:withNSString:", "init", NULL, 0x0, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "this$0_", NULL, 0x1012, "Lcom.goodow.realtime.channel.impl.ReliableSubscribeBus$2;", NULL,  },
    { "val$replyTopic_", NULL, 0x1012, "Ljava.lang.String;", NULL,  },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplReliableSubscribeBus_$2_$1 = { "$1", "com.goodow.realtime.channel.impl", "ReliableSubscribeBus$$2", 0x8000, 2, methods, 2, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplReliableSubscribeBus_$2_$1;
}

@end

@implementation ComGoodowRealtimeChannelImplReliableSubscribeBus_$3

- (void)handleWithId:(id)event {
  if ([((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->acknowledgeScheduled_)) hasWithNSString:val$topic_]) {
    (void) [this$0_->acknowledgeScheduled_ removeWithNSString:val$topic_];
    double knownHeadSequence = [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->knownHeadSequences_)) getNumberWithNSString:val$topic_];
    double currentSequence = [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->currentSequences_)) getNumberWithNSString:val$topic_];
    if (knownHeadSequence > currentSequence && (![((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->acknowledgeNumbers_)) hasWithNSString:val$topic_] || knownHeadSequence > [this$0_->acknowledgeNumbers_ getNumberWithNSString:val$topic_])) {
      (void) [((id<ComGoodowRealtimeJsonJsonObject>) nil_chk(this$0_->acknowledgeNumbers_)) setWithNSString:val$topic_ withDouble:knownHeadSequence];
      [((JavaUtilLoggingLogger *) nil_chk(ComGoodowRealtimeChannelImplReliableSubscribeBus_get_log_())) logWithJavaUtilLoggingLevel:JavaUtilLoggingLevel_get_CONFIG_() withNSString:[NSString stringWithFormat:@"Catching up to %f", knownHeadSequence]];
      [this$0_ catchupWithNSString:val$topic_ withDouble:currentSequence];
    }
    else {
      [((JavaUtilLoggingLogger *) nil_chk(ComGoodowRealtimeChannelImplReliableSubscribeBus_get_log_())) logWithJavaUtilLoggingLevel:JavaUtilLoggingLevel_get_FINE_() withNSString:@"No need to catchup"];
    }
  }
}

- (id)initWithComGoodowRealtimeChannelImplReliableSubscribeBus:(ComGoodowRealtimeChannelImplReliableSubscribeBus *)outer$
                                                  withNSString:(NSString *)capture$0 {
  this$0_ = outer$;
  val$topic_ = capture$0;
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "handleWithJavaLangVoid:", "handle", "V", 0x1, NULL },
    { "initWithComGoodowRealtimeChannelImplReliableSubscribeBus:withNSString:", "init", NULL, 0x0, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "this$0_", NULL, 0x1012, "Lcom.goodow.realtime.channel.impl.ReliableSubscribeBus;", NULL,  },
    { "val$topic_", NULL, 0x1012, "Ljava.lang.String;", NULL,  },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplReliableSubscribeBus_$3 = { "$3", "com.goodow.realtime.channel.impl", "ReliableSubscribeBus", 0x8000, 2, methods, 2, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplReliableSubscribeBus_$3;
}

@end

@implementation ComGoodowRealtimeChannelImplReliableSubscribeBus_$4

- (void)handleWithId:(id)event {
  [((id<ComGoodowRealtimeJsonJsonArray>) nil_chk(val$messages_)) forEachWithComGoodowRealtimeJsonJsonArray_ListIterator:[[ComGoodowRealtimeChannelImplReliableSubscribeBus_$4_$1 alloc] initWithComGoodowRealtimeChannelImplReliableSubscribeBus_$4:self]];
}

- (id)initWithComGoodowRealtimeChannelImplReliableSubscribeBus:(ComGoodowRealtimeChannelImplReliableSubscribeBus *)outer$
                            withComGoodowRealtimeJsonJsonArray:(id<ComGoodowRealtimeJsonJsonArray>)capture$0 {
  this$0_ = outer$;
  val$messages_ = capture$0;
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "handleWithJavaLangVoid:", "handle", "V", 0x1, NULL },
    { "initWithComGoodowRealtimeChannelImplReliableSubscribeBus:withComGoodowRealtimeJsonJsonArray:", "init", NULL, 0x0, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "this$0_", NULL, 0x1012, "Lcom.goodow.realtime.channel.impl.ReliableSubscribeBus;", NULL,  },
    { "val$messages_", NULL, 0x1012, "Lcom.goodow.realtime.json.JsonArray;", NULL,  },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplReliableSubscribeBus_$4 = { "$4", "com.goodow.realtime.channel.impl", "ReliableSubscribeBus", 0x8000, 2, methods, 2, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplReliableSubscribeBus_$4;
}

@end

@implementation ComGoodowRealtimeChannelImplReliableSubscribeBus_$4_$1

- (void)callWithInt:(int)index
             withId:(id<ComGoodowRealtimeChannelMessage>)message {
  (void) [((id<ComGoodowRealtimeChannelBus>) nil_chk(this$0_->this$0_->delegate_)) publishLocalWithNSString:[((id<ComGoodowRealtimeChannelMessage>) nil_chk(message)) topic] withId:[message body]];
}

- (id)initWithComGoodowRealtimeChannelImplReliableSubscribeBus_$4:(ComGoodowRealtimeChannelImplReliableSubscribeBus_$4 *)outer$ {
  this$0_ = outer$;
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "callWithInt:withComGoodowRealtimeChannelMessage:", "call", "V", 0x1, NULL },
    { "initWithComGoodowRealtimeChannelImplReliableSubscribeBus_$4:", "init", NULL, 0x0, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "this$0_", NULL, 0x1012, "Lcom.goodow.realtime.channel.impl.ReliableSubscribeBus$4;", NULL,  },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplReliableSubscribeBus_$4_$1 = { "$1", "com.goodow.realtime.channel.impl", "ReliableSubscribeBus$$4", 0x8000, 2, methods, 1, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplReliableSubscribeBus_$4_$1;
}

@end
