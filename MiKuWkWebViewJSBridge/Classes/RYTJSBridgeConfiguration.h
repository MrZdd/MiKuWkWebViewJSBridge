//
//  RYTJSBridgeConfiguration.h
//  RYTWKWebViewJSBridge
//
//  Created by Baby Miku on 2020/11/11.
//  Copyright © 2020 RYT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RYTJSBridgeConfiguration : NSObject

+ (instancetype)sharedConfiguration;

#pragma mark - Invocation

- (BOOL)registerFunction:(NSString *)function withInvocationClass:(Class)invocationClass;

- (nullable Class)invocationClassForFunction:(NSString *)function;

@end

NS_ASSUME_NONNULL_END
