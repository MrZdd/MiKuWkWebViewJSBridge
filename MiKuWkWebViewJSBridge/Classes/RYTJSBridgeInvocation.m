//
//  RYTJSBridgeInvocation.m
//  RYTWKWebViewJSBridge
//
//  Created by Baby Miku on 2020/11/11.
//  Copyright © 2020 RYT. All rights reserved.
//

#import "RYTJSBridgeInvocation.h"

@interface RYTJSBridgeInvocation()

@property (nonatomic, weak, readwrite) RYTWKJSBridge *JSBridge;
@property (nonatomic, weak, readwrite) UIViewController *webViewController;

@property (nonatomic, copy, readwrite) NSString *nativeCallBackString;
@end

@implementation RYTJSBridgeInvocation

- (void)initWithWebViewController:(UIViewController *)webViewController bindJSBridge:(RYTWKJSBridge *)JSBridge {
    self.JSBridge = JSBridge;
    self.webViewController = webViewController;
}

- (void)setNativeCallBackString:(NSString *)nativeCallBackString {
    _nativeCallBackString = nativeCallBackString;
}

@end
