//
//  UniPageLifeCycle.h
//  unify_uni_page
//
//  Created by jerry on 2024/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define kLifecycle  @"Lifecycle"
#define kMsgSender  @"MsgSender"

typedef NS_OPTIONS(NSUInteger, UniPageSubscriptionLifecycle) {
    UPSLifeCycleViewDidLoad = 0, // index 索引
    UPSLifeCycleViewDidLayoutSubViews,
    UPSLifeCycleViewWillAppear,
    UPSLifeCycleViewDidAppear,
    UPSLifeCycleViewWillDisappear,
    UPSLifeCycleViewDidDisappear
};

@protocol UniPageLifeCycle <NSObject>
@optional

/// 同步Page viewDidLoad方法
- (void)viewDidLoad NS_REQUIRES_SUPER;

/// 同步Page layoutSubviews方法
- (void)viewDidLayoutSubviews NS_REQUIRES_SUPER;

/// 同步Page viewWillAppear方法
- (void)viewWillAppear NS_REQUIRES_SUPER;

/// 同步Page viewDidAppear方法
- (void)viewDidAppear NS_REQUIRES_SUPER;

/// 同步Page viewWillDisappear方法
- (void)viewWillDisappear NS_REQUIRES_SUPER;

/// 同步Page viewDidDisappear方法
- (void)viewDidDisappear NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
