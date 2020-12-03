//
//  RYTJSBridgeConfiguration.m
//  RYTWKWebViewJSBridge
//
//  Created by Baby Miku on 2020/11/11.
//  Copyright © 2020 RYT. All rights reserved.
//

#import "RYTJSBridgeConfiguration.h"

@interface RYTJSBridgeConfiguration()

@property (nonatomic, strong)NSMutableDictionary<NSString *,Class> *invocationClassDict;
@end

@implementation RYTJSBridgeConfiguration

+ (instancetype)sharedConfiguration {
    static dispatch_once_t onceToken;
    static RYTJSBridgeConfiguration *_sharedConfiguration = nil;
    dispatch_once(&onceToken, ^{
        _sharedConfiguration = [[RYTJSBridgeConfiguration alloc]init];
    });
    return _sharedConfiguration;
}

- (NSMutableDictionary *)invocationClassDict {
    if (_invocationClassDict == nil) {
        _invocationClassDict = [[NSMutableDictionary alloc]init];
    }
    return _invocationClassDict;
}
- (BOOL)registerFunction:(NSString *)function withInvocationClass:(Class)invocationClass {
    [self.invocationClassDict setObject:invocationClass forKey:function];
    return YES;
}

- (nullable Class)invocationClassForFunction:(NSString *)function {
    Class class = [self.invocationClassDict objectForKey:function];
    return class;
}

@end
