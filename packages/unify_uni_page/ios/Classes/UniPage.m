//
//  UniPage.m
//  unify_uni_page
//
//  Created by jerry on 2024/7/16.
//

#import "UniPage.h"
#import "UniPageConstants.h"

@interface UniPage()<FlutterPlatformView>

@property (nonatomic, copy) NSString *viewType;
@property (nonatomic, assign) int64_t viewId;
@property (nonatomic, strong) NSDictionary *arguments;
@property (nonatomic, strong) FlutterMethodChannel *channel;
@property (nonatomic, assign) BOOL isPosted;

@end

@implementation UniPage

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self onDispose];
}

- (instancetype)initWithWithFrame:(CGRect)frame
                         viewType:(NSString*)viewType
                   viewIdentifier:(int64_t)viewId
                        arguments:(NSDictionary *)args
                  binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    if ([super init]) {
        self.viewId = viewId;
        self.viewType = viewType;
        self.arguments = args;
        self.channel = [FlutterMethodChannel methodChannelWithName:[self createChannelName:viewType viewId:viewId] binaryMessenger:messenger];
        __weak __typeof(self) weakSelf = self;
        [self.channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf onMethodCall:call result:result];
        }];
        
        NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
        [center addObserver:self
                   selector:@selector(applicationWillEnterForeground:)
                       name:UIApplicationWillEnterForegroundNotification
                     object:nil];

        [center addObserver:self
                   selector:@selector(applicationDidEnterBackground:)
                       name:UIApplicationDidEnterBackgroundNotification
                     object:nil];
    }
    return self;
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
    
    NSDictionary *params = @{
        UNI_PAGE_CHANNEL_PARAMS_PATH: routePath,
        UNI_PAGE_CHANNEL_PARAMS_PARAMS: args
    };
    
    [self.channel invokeMethod:UNI_PAGE_ROUTE_PUSH_NAMED arguments:params];
}

- (void)pop:(id)result {
    NSAssert(result != nil, @"result cannot be nil");
    
    NSDictionary *params = @{
        UNI_PAGE_CHANNEL_PARAMS_PARAMS: result
    };
    
    [self.channel invokeMethod:UNI_PAGE_ROUTE_POP arguments:params];
}

- (void)invoke:(NSString*)methodName arguments:(id _Nullable)params {
    [self invoke:methodName arguments:params result:nil];
}

- (void)invoke:(NSString*)methodName
     arguments:(id _Nullable)params
        result:(FlutterResult _Nullable)callback {
    NSAssert(methodName != nil, @"methodName cannot be nil");
    
    NSDictionary *arguments = @{
        UNI_PAGE_CHANNEL_VIEW_TYPE: self.viewType,
        UNI_PAGE_CHANNEL_VIEW_ID: @(self.viewId),
        UNI_PAGE_CHANNEL_METHOD_NAME: methodName,
        UNI_PAGE_CHANNEL_PARAMS_PARAMS: params != nil ? params : @{},
    };
    
    [self.channel invokeMethod:UNI_PAGE_CHANNEL_INVOKE arguments:arguments result:callback];
}

- (id)onMethodCall:(NSString*)methodName params:(NSDictionary *)args {
    return nil;
}

- (int64_t)getViewId {
    return self.viewId;
}

- (NSDictionary*)getCreationParams {
    return self.arguments;
}

- (NSString*)getViewType {
    return self.viewType;
}


- (void)onCreate {
    
}

- (void)postCreate {
    
}

- (void)onForeground {
    
}

- (void)onBackground {
    
}

- (void)onDispose {
    
}

#pragma mark - Notifications

- (void)applicationWillEnterForeground:(NSNotification*)notification {
  [self onForeground];
}

- (void)applicationDidEnterBackground:(NSNotification*)notification {
  [self onBackground];
}

#pragma mark - FlutterPlatformView

/// 返回真正的视图
- (UIView *)view {
    [self onCreate];
    return self;
}

#pragma mark - private methods

- (NSString*)createChannelName:(NSString*)viewType viewId:(int64_t)viewId {
    return [NSString stringWithFormat:@"%@.%@.%lld", UNI_PAGE_CHANNEL, viewType, viewId];
}

- (void)onMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:UNI_PAGE_CHANNEL_INVOKE]) {
        id args = call.arguments;
        NSString *methodName = [args objectForKey:UNI_PAGE_CHANNEL_METHOD_NAME];
        id params = [args objectForKey:UNI_PAGE_CHANNEL_PARAMS_PARAMS];
        id ret = [self onMethodCall:methodName params:params];
        result(ret);
        return;
    }
    result(nil);
}

@end
