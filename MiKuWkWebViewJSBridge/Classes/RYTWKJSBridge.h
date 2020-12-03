//
//  RYTWKJSBridge.h
//  RYTWKWebViewJSBridge
//
//  Created by HUAWEI on 2020/4/23.
//  Copyright © 2020 RYT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "RYTWKJSBridgeCallBackProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RYTWKJSBridge : NSObject<RYTWKJSBridgeCallBackProtocol>


+ (instancetype)initWithWebViewController:(UIViewController *)webViewController bindJSBridgeWithWebView:(WKWebView *)webView;
- (instancetype)init NS_UNAVAILABLE;

@property (nonatomic, readonly, weak)WKWebView *webView;
@property (nonatomic, readonly, weak)UIViewController *webViewController;


@end

NS_ASSUME_NONNULL_END
