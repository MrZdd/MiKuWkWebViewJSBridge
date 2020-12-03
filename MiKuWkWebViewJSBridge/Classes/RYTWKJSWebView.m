//
//  RYTWKJSWebView.m
//  RYTWKWebViewJSBridge
//
//  Created by HUAWEI on 2020/4/23.
//  Copyright © 2020 RYT. All rights reserved.
//

#import "RYTWKJSWebView.h"

@implementation RYTWKJSWebView

- (instancetype)initWithConfig:(WKWebViewConfiguration *)Config frame:(CGRect)frame bridgeJSString:(NSString *__nullable)bridgeJSString{
    if (self = [super initWithFrame:frame configuration:Config]) {
        [self config:bridgeJSString];
    }
    return self;
}
- (void)config:(NSString *)bridgeJSString {
    
    // 注入脚本
    NSString *scriptPath = bridgeJSString?:[[NSBundle mainBundle]pathForResource:@"BROSJSBridge" ofType:@"js"];
    
    NSString *bridgeString = [[NSString alloc] initWithContentsOfFile:scriptPath encoding:NSUTF8StringEncoding error:NULL];
    
    WKUserScript *userScript = [[WKUserScript alloc] initWithSource:bridgeString injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    
    [self.configuration.userContentController addUserScript:userScript];
}

- (void)dealloc {
    
    //清除UserScript
    [self.configuration.userContentController removeAllUserScripts];
    
    //停止加载
    [self stopLoading];
    
    //清空相关delegate
    [super setUIDelegate:nil];
    [super setNavigationDelegate:nil];
}

@end
