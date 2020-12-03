//
//  RYTJSBridgeInvocation.h
//  RYTWKWebViewJSBridge
//
//  Created by Baby Miku on 2020/11/11.
//  Copyright © 2020 RYT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RYTWKJSBridge.h"

NS_ASSUME_NONNULL_BEGIN

@interface RYTJSBridgeInvocation : NSObject

@property (nonatomic, weak, readonly) RYTWKJSBridge *JSBridge;
@property (nonatomic, weak, readonly) UIViewController *webViewController;

@property (nonatomic, copy, readonly) NSString *nativeCallBackString;

@end

NS_ASSUME_NONNULL_END
