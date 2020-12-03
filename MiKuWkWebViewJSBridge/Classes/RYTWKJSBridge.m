//
//  RYTWKJSBridge.m
//  RYTWKWebViewJSBridge
//
//  Created by HUAWEI on 2020/4/23.
//  Copyright © 2020 RYT. All rights reserved.
//

#import "RYTWKJSBridge.h"
#import "RYTWKJSBridgeMessageHandlerDelegate.h"
#import "NSString+BridgeJSONPrivate.h"
#import "RYTJSBridgeInvocation.h"
#import "RYTJSBridgeConfiguration.h"

static NSString * const WKJSBridgeString = @"native";

@interface RYTWKJSBridge()<WKScriptMessageHandler>

@property (nonatomic, readwrite, weak)WKWebView *webView;
@property (nonatomic, readwrite, weak)UIViewController *webViewController;

@property (nonatomic, strong)NSMutableArray *invocationArray;

@property (nonatomic, strong)NSLock *lock;

@end

@implementation RYTWKJSBridge

- (NSMutableArray *)invocationArray {
    if (_invocationArray == nil) {
        _invocationArray = [[NSMutableArray alloc]init];
    }
    return _invocationArray;
}

- (NSLock *)lock {
    if (_lock == nil) {
        _lock = [[NSLock alloc]init];
    }
    return _lock;
}

+ (instancetype)initWithWebViewController:(UIViewController *)webViewController bindJSBridgeWithWebView:(WKWebView *)webView{
    RYTWKJSBridge *jsBridge = [[self alloc]initJSBridgeWithWebView:webView bindWithController:webViewController];
    return jsBridge;
}

#pragma mark - Init
- (instancetype)initJSBridgeWithWebView:(WKWebView *)webView bindWithController:(UIViewController *)webViewController{
    if (self = [super init]) {
        self.webView = webView;
        self.webViewController = webViewController;
        [self setup];
    }
    return self;
}

- (void)setup {

    WKWebViewConfiguration *webViewConfiguration = self.webView.configuration;
    if (webViewConfiguration && !webViewConfiguration.userContentController) {
        self.webView.configuration.userContentController = [WKUserContentController new];
    }
    // 防止内存泄露
    [self.webView.configuration.userContentController addScriptMessageHandler:[[RYTWKJSBridgeMessageHandlerDelegate alloc] initWithDelegate:self] name:WKJSBridgeString];
}

#pragma mark ----WKWebview代理----

- (void)userContentController:(nonnull WKUserContentController *)userContentController didReceiveScriptMessage:(nonnull WKScriptMessage *)message {
    if ([message.name isEqualToString:WKJSBridgeString]) {
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:message.body];
        NSString *className = [message.body objectForKey:@"methodName"];
        Class class = [[RYTJSBridgeConfiguration sharedConfiguration] invocationClassForFunction:[className stringByReplacingOccurrencesOfString:@":" withString:@""]];
        id object = [[class alloc]init];
        SEL methodSeletor = NSSelectorFromString(@"invokeWithParameters:");
        if ([object respondsToSelector:methodSeletor]) {
            [object performSelector:@selector(initWithWebViewController:bindJSBridge:) withObject:self.webViewController withObject:self];
            NSString *nativeCallBackString = dic[@"nativeCallBack"] ;
            if (nativeCallBackString.length > 0) {
                [object performSelector:@selector(setNativeCallBackString:) withObject:dic[@"nativeCallBack"]];
            }
            [self.lock lock];
            [self.invocationArray addObject:object];
            [self.lock unlock];
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc]initWithDictionary:message.body];
            [parameters removeObjectForKey:@"methodName"];
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [object performSelector:methodSeletor withObject:parameters];
        #pragma clang diagnostic pop
            } else {
            NSString *methodNotFound = [NSString stringWithFormat:@"%@('%@')", @"classNotFound", [className stringByReplacingOccurrencesOfString:@":" withString:@""]];
            [self.webView evaluateJavaScript:methodNotFound completionHandler:nil];
          }
            
       }
}
- (void)sendResult:(NSString *)funcStr parameter:(NSDictionary *)parameter {
    if (funcStr && funcStr.length > 0) {
        
        NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:parameter];
        [newDic setObject:funcStr forKey:@"callbackId"];
        NSString *paramStr = [NSString jsonStringFromeDiction:newDic];
        NSString *jsStr = [NSString stringWithFormat:@"onCallback(%@)",paramStr];
        [self sendResultToJS:jsStr parameter:nil];
        
    }else {
       
    }
}
#pragma mark ----evaluateJavaScript----
- (void)sendResultToJS:(nonnull id)result parameter:(_Nullable id)parameter {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(evalJs:) withObject:result waitUntilDone:NO];
    }else {
        [self evalJs:result];
    }
}

- (void)evalJs:(NSString *)js {
    [self.webView evaluateJavaScript:js completionHandler:^(id _Nonnull obj, NSError * _Nonnull error) {
    }];
}

- (void)removeInvocationObject:(id)Object {
    [self.lock lock];
    [self.invocationArray removeObject:Object];
    [self.lock unlock];
}

- (void)dealloc {
    WKWebView *webView = (WKWebView *)self.webView;
    [webView.configuration.userContentController removeScriptMessageHandlerForName:WKJSBridgeString];
    [self.invocationArray removeAllObjects];
}

@end
