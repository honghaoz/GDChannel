//
//  ViewController.m
//  Demo
//
//  Created by Honghao Zhang on 2014-10-27.
//  Copyright (c) 2014 HonghaoZ. All rights reserved.
//

#import "ViewController.h"
#import "GDChannel.h"

@interface ViewController ()

@property (nonatomic, strong) id<GDCBus> bus;
@property (nonatomic, strong) __block id<GDCRegistration> registration;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bus = [[GDCReconnectWebSocketBus alloc] initWithServerUri:@"ws://realtime.goodow.com:1986/channel/websocket" options:nil];

    [self.bus subscribe:GDC_BUS_ON_OPEN handler:^(id <GDCMessage> message) {
        NSLog(@"%@", @"EventBus opend");
    }];
    [self.bus subscribe:GDC_BUS_ON_CLOSE handler:^(id <GDCMessage> message) {
        NSLog(@"%@", @"EventBus closed");
    }];
    [self.bus subscribe:GDC_BUS_ON_ERROR handler:^(id <GDCMessage> message) {
        NSLog(@"%@", @"EventBus Error");
    }];
    
    self.registration = [self.bus subscribe:@"playground/0" handler:^(id <GDCMessage> message) {
        NSMutableDictionary *body = [message body];
        //        XCTAssertTrue([@"send1" isEqualToString:[body objectForKey:@"text"]]);
        
        self.sendButton.titleLabel.text = @"HAHAHAHA";
        
        NSDictionary *msg = @{@"text" : @"reply1"};
        [message reply:msg replyHandler:^(id <GDCMessage> message) {
            NSMutableDictionary *body = [message body];
            NSLog(@"%@", body);
            //            XCTAssertTrue([@"reply2" isEqualToString:[body objectForKey:@"text"]]);
            NSLog(@"%@", message);
            
            [self.registration unregister];
            self.registration = nil;
            [self.bus close];
        }];
    }];
}

- (IBAction)send:(id)sender {
    [self.bus send:@"playground/0" message:@{@"text": @"send1"} replyHandler:^(id<GDCMessage> message) {
        NSLog(@"Replyed!!!");
        NSMutableDictionary *body = [message body];
        NSLog(@"%@", body);
        //        XCTAssertTrue([@"reply1" isEqualToString:[body objectForKey:@"text"]]);
        
        [message reply:@{@"text": @"reply2"}];
    }];
}

@end
