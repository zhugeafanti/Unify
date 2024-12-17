//
//  UniPage.m
//  unify_uni_page
//
//  Created by jerry on 2024/7/16.
//

#import "UniPage.h"
#import "UniPageConstants.h"
#import "UIView+GetController.h"
#import "UniPageMsgCenter.h"

/// 通知名，周知UniPage，FlutterViewController将要dealloc
NSString *const NotifyUniPageFlutterViewControllerWillDealloc = @"NotifyUniPageFlutterViewControllerWillDealloc";

@interface UniPage()

@property (nonatomic, assign) BOOL isPosted;
@property (nonatomic, assign) NSUInteger ownerId;
@property (nonatomic, weak) UIViewController* ownerVC;

@end

@implementation UniPage

- (void)dealloc {
    NSLog(@"jerry - 1017 dealloc UniPage: %@", self);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.isPosted) {
        [self postCreate];
        self.isPosted = YES;
    }
}

#pragma - public methods

- (void)pushNamed:(NSString*)routePath param:(NSDictionary *)args {
    NSAssert(routePath != nil, @"routePath cannot be nil");
    NSAssert(args != nil, @"args cannot be nil");

    if (self.delegate && [self.delegate respondsToSelector:@selector(pushNamed:param:)]) {
        [self.delegate pushNamed:routePath param: args];
    }
}

- (void)pop:(id)result {
    NSAssert(result != nil, @"result cannot be nil");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pop:)]) {
        [self.delegate pop:result];
    }
}

- (void)invoke:(NSString*)methodName arguments:(id _Nullable)params {
    [self invoke:methodName arguments:params result:nil];
}

- (void)invoke:(NSString*)methodName
     arguments:(id _Nullable)params
        result:(FlutterResult _Nullable)callback {
    NSAssert(methodName != nil, @"methodName cannot be nil");
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(invoke:arguments:result:)]) {
        [self.delegate invoke:methodName arguments:params result:callback];
    }
}

- (id)onMethodCall:(NSString*)methodName params:(NSDictionary *)args {
    return nil;
}

- (int64_t)getViewId {
    int64_t viewId = -1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getViewId)]) {
        viewId = [self.delegate getViewId];
    }
    return viewId;
}

- (NSDictionary*)getCreationParams {
    NSDictionary *params;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getCreationParams)]) {
        params = [self.delegate getCreationParams];
    }
    return params;
}

- (NSString*)getViewType {
    NSString *viewType;
    if (self.delegate && [self.delegate respondsToSelector:@selector(getViewType)]) {
        viewType = [self.delegate getViewType];
    }
    return viewType;
}


- (void)onCreate {
    
}

- (void)postCreate {
    _ownerVC = [self currentController];
    _ownerId = [_ownerVC hash];
}

- (void)onForeground {
    
}

- (void)onBackground {
    
}

- (void)onDispose {
    
}

- (NSUInteger)getOwnerId {
    return self.ownerId;
}

- (UIViewController*)ownerVC {
    return _ownerVC;
}

#pragma mark - life cycle

- (void)subscribeLifeCycle {
    __weak typeof(self) weakSelf = self;
    [[UniPageMsgCenter defaultCenter] registerObserver:self event:^(id  _Nonnull info) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UniPageSubscriptionLifecycle lifeCycle = [info[kLifecycle] intValue];
        UIViewController *vc = info[kMsgSender];
        /*
         判断当前视图所属的 VC 是否正在展示
         只有正在展示的 UniPage 才感知VC的生命周期，未展示的不感知VC生命周期
         */
        if([strongSelf isSelfOrChildVC:strongSelf.ownerVC of:vc]) {
            [strongSelf execLifeCycle: lifeCycle];
        }
    }];
}

- (void)unsubscribeLifeCycle {
    [[UniPageMsgCenter defaultCenter] unregisterObserver:self];
}

//组件创建
- (void)viewDidLoad { }
//组件即将显示
- (void)viewWillAppear { }
//组件显示
- (void)viewDidAppear { }
//组件即将消失
- (void)viewWillDisappear { }
//组件消失
- (void)viewDidDisappear { }

- (void)viewDidLayoutSubviews { }

#pragma mark - private

- (void)execLifeCycle:(UniPageSubscriptionLifecycle)lifeCycle {
    NSString *selStr = self.lifeCycleSelectors[lifeCycle];
    SEL selector = NSSelectorFromString(selStr);
    if([self respondsToSelector:selector]){
        /*
         * 处理⚠️信息：performSelector may cause a leak because its selector unknow [-Warc-performSelector-leaks]
         * 由 clang 编译器去处理
         */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector];
#pragma clang diagnostic pop
    }
}

- (NSArray *)lifeCycleSelectors {
    static NSArray *__lifeCycleSelectors = nil;
    if(!__lifeCycleSelectors){
        __lifeCycleSelectors = @[NSStringFromSelector(@selector(viewDidLoad)),
                                 NSStringFromSelector(@selector(viewDidLayoutSubviews)),
                                 NSStringFromSelector(@selector(viewWillAppear)),
                                 NSStringFromSelector(@selector(viewDidAppear)),
                                 NSStringFromSelector(@selector(viewWillDisappear)),
                                 NSStringFromSelector(@selector(viewDidDisappear))];
    }
    return __lifeCycleSelectors;
    
}

- (BOOL)isSelfOrChildVC:(UIViewController*)child of:(UIViewController*)parent {
    if (child == parent) {
        return YES;
    }
    
    for (UIViewController *subVc in parent.childViewControllers) {
        if ([self isSelfOrChildVC:child of:subVc]) {
            return YES;
        }
    }
    
    return NO;
}

@end
