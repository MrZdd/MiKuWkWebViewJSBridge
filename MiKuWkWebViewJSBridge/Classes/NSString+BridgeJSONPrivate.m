//
//  NSString+BridgeJSONPrivate.m
//  RYTWKWebViewJSBridge
//
//  Created by HUAWEI on 2020/4/23.
//  Copyright © 2020 RYT. All rights reserved.
//

#import "NSString+BridgeJSONPrivate.h"

@implementation NSString (BridgeJSONPrivate)
+ (NSString *)jsonStringFromeDiction:(NSDictionary *)dic {
    @autoreleasepool {
         NSError *parseError = nil;
         NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
         NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
         NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
         NSRange range = {0,jsonStr.length};
         //去掉字符串中的空格
         [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
         NSRange range2 = {0,mutStr.length};
         //去掉字符串中的换行符
         [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
         return mutStr;
    }
}
@end
