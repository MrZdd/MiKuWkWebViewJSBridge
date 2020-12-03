//
//  RYTJSBridgeInvocation+Protected.h
//  RYTWKWebViewJSBridge
//
//  Created by Baby Miku on 2020/11/11.
//  Copyright © 2020 RYT. All rights reserved.
//

#import "RYTJSBridgeInvocation.h"

NS_ASSUME_NONNULL_BEGIN

@interface RYTJSBridgeInvocation (Protected)

#pragma mark - Invoke

/*!
 * @override
 *  JS API 的执行方法，由子类负责实现。
 *
 * @attention
 *  当 Web 页面调用某个 JS API 时，JSBridge 内部会执行此方法。
 *  因此，子类或其他调用者不应该调用此方法。
 *
 * @attention
 *  在 invoke 完成时，子类必须调用 `-completeWithReturnValue:extendedValue:`。
 */
- (void)invokeWithParameters:(nullable NSDictionary *)parameters;

#pragma mark - Customized Callback

/*!
 * 回调 JS API parameters 参数里的回调函数。
 *
 * @param identifier    回调标识。
 *                      例如，JS 执行了如下代码：
 *                      `
 *                          BROSJSBridge.invoke("setAlertInfo", setInfo)
 *                      `
 *                      则在 JS API 对应的 invocation 子类中，在 `-invocationWithParameters:` 的实现中，
 *                      用以下方式可以回调 progress 方法：
 *                      `
 *                          [self callbackWithIdentifier:setInfo[@"xxxxx"] values:values];
 *                      `
 */
- (void)callbackWithIdentifier:(id)identifier values:(nullable NSDictionary *)values;

#pragma mark - Completion Callback

/*!
 * 在 invoke 有结果时，子类通过调用 `-finishWithValues:` 进行成功回调。
 * 此方法会把 invoke 的返回值回调到 Web 页面。
 *
 * @param completed     是否完成 JS API 的执行，
 *                      若为 YES，则会调用 `-complete` 方法，
 *                      若为 NO，在 JS API 任务结束后需要由子类调用 `-complete` 方法，
 *                      在此以前，子类仍然可以通过调用 `-callbackWithIdentifier:values` 进行自定义回调回调自定义方法。
 */
- (void)finishWithValues:(nullable NSDictionary *)values completed:(BOOL)completed;

#pragma mark - Complete

/*!
 * 完成 JS API 的执行。
 *
 * 在 invoke 的所有任务完成时，子类必须要调用 `-complete`。
 * JSBridge 收到 complete 通知后，将会销毁当前 invocation 实例，
 * 此后，invocation 的所有执行将停止，无法再向 Web 页面进行回调。
 */
- (void)complete;

@end

NS_ASSUME_NONNULL_END
