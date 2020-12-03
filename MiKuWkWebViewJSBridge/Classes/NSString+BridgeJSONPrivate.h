//
//  NSString+BridgeJSONPrivate.h
//  RYTWKWebViewJSBridge
//
//  Created by HUAWEI on 2020/4/23.
//  Copyright © 2020 RYT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (BridgeJSONPrivate)
+ (NSString *)jsonStringFromeDiction:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
