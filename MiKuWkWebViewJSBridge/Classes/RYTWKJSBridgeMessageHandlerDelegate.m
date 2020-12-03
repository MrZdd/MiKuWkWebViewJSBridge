//
//  RYTWKJSBridgeMessageHandlerDelegate.m
//  RYTWKWebViewJSBridge
//
//  Created by HUAWEI on 2020/4/23.
//  Copyright © 2020 RYT. All rights reserved.
//

#import "RYTWKJSBridgeMessageHandlerDelegate.h"

@implementation RYTWKJSBridgeMessageHandlerDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _jsBridgeDelegate = scriptDelegate;
    }
    return self;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.jsBridgeDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
