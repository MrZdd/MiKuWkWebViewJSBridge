//
//  RYTWKJSBridgeCallBackProtocol.h
//  RYTWKWebViewJSBridge
//
//  Created by HUAWEI on 2020/4/24.
//  Copyright © 2020 RYT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RYTWKJSBridgeCallBackProtocol <NSObject>
/**
 原生模块回调js
 
 @param funcStr 方法ID
 @param parameter 参数
 */
- (void)sendResult:(NSString * _Nullable)funcStr parameter:(NSDictionary * _Nullable)parameter;
@end

NS_ASSUME_NONNULL_END
