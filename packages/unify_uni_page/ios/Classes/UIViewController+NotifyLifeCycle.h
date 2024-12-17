//
//  UIViewController+NotifyLifeCycle.h
//  unify_uni_page
//
//  Created by jerry on 2024/12/10.
//

#import <UIKit/UIKit.h>
#import "UniPageLifeCycle.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NotifyLifeCycle)

- (void)uniNotifyLifeCycle:(UniPageSubscriptionLifecycle)lifeCycle;

@end

NS_ASSUME_NONNULL_END
