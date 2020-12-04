//
//  RYTJSBridgeInvocation+Protected.m
//  RYTWKWebViewJSBridge
//
//  Created by Baby Miku on 2020/11/11.
//  Copyright © 2020 RYT. All rights reserved.
//

#import "RYTJSBridgeInvocation+Protected.h"
#import "RYTJSBridgeConfiguration.h"
@implementation RYTJSBridgeInvocation (Protected)

- (void)invokeWithParameters:(NSDictionary *)parameters {
    
    
    
    
}

- (void)callbackWithIdentifier:(id)identifier values:(NSDictionary *)values {
    [self.JSBridge sendResult:identifier parameter:values];
}

- (void)finishWithValues:(NSDictionary *)values completed:(BOOL)completed {
    [self.JSBridge sendResult:self.nativeCallBackString parameter:values];
    if (completed == YES) {
        [self complete];
    }
}

- (void)complete {
    [self.JSBridge performSelector:@selector(removeInvocationObject:) withObject:self];
}

@end
