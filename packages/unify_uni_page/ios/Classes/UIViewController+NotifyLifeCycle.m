//
//  UIViewController+NotifyLifeCycle.m
//  unify_uni_page
//
//  Created by jerry on 2024/12/10.
//

#import "UIViewController+NotifyLifeCycle.h"
#import "UniPageMsgCenter.h"

@implementation UIViewController (NotifyLifeCycle)

- (void)notifyLifeCycle:(UniPageSubscriptionLifecycle)lifeCycle {
    [[UniPageMsgCenter defaultCenter] postMessage:@{kLifecycle: @(lifeCycle),
                                                           kMsgSender: self
                                                  }];
}

@end
