//
//  RYTWKJSBridgeMessageHandlerDelegate.h
//  RYTWKWebViewJSBridge
//
//  Created by HUAWEI on 2020/4/23.
//  Copyright © 2020 RYT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RYTWKJSBridgeMessageHandlerDelegate : NSObject<WKScriptMessageHandler>


@property (nonatomic, weak) id <WKScriptMessageHandler>jsBridgeDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end

NS_ASSUME_NONNULL_END
