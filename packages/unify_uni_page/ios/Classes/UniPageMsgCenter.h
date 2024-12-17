//
//  UniPageMsgCenter.h
//  unify_uni_page
//
//  Created by jerry on 2024/12/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UniPageLifeCycleEvent)(id info);

@interface UniPageMsgCenter : NSObject

+ (instancetype)defaultCenter;

/**
 添加Event事件

 @param event event事件回调
 @param observer 监听者
 */
- (void)registerObserver:(NSObject *)observer event:(UniPageLifeCycleEvent)event;

/**
 发送消息

 @param info 传值
 */
- (void)postMessage:(id)info;

/**
 移出所有observer对应的事件

 @param observer 监听者
 */
- (void)unregisterObserver:(NSObject *)observer;

@end

NS_ASSUME_NONNULL_END
