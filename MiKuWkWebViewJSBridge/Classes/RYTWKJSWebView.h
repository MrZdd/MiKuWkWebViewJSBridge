//
//  RYTWKJSWebView.h
//  RYTWKWebViewJSBridge
//
//  Created by HUAWEI on 2020/4/23.
//  Copyright © 2020 RYT. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RYTWKJSWebView : WKWebView

- (instancetype)initWithConfig:(WKWebViewConfiguration *)Config frame:(CGRect)frame bridgeJSString:(NSString * __nullable)bridgeJSString;

@end

NS_ASSUME_NONNULL_END
