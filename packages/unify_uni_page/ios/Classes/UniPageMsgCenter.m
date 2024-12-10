//
//  UniPageMsgCenter.m
//  unify_uni_page
//
//  Created by jerry on 2024/12/10.
//

#import "UniPageMsgCenter.h"
#import <objc/runtime.h>

#define kUniPageSubscribeLifeCycle @"UniPageSubscribeLifeCycle"

static BOOL isMainQueue(void)
{
    static void *mainQKey = &mainQKey;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_set_specific(dispatch_get_main_queue(),
                                    mainQKey, mainQKey, NULL);
    });
    return dispatch_get_specific(mainQKey) == mainQKey;
}

static void ExecOnMainQueue(dispatch_block_t block)
{
    if (isMainQueue()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

////////////////////////////////////////////////////

@interface UniPageEventObject : NSObject
@property (nonatomic, copy) UniPageMsgEvent eventHandler;
@end

@implementation UniPageEventObject

- (void)dealloc {
    //NSLog(@"observer - dealloc");
}

@end

////////////////////////////////////////////////////

@interface UniPageEventSet : NSObject
@property (nonatomic, strong) NSMutableDictionary<NSString*,UniPageEventObject *> *eventObjectMap;
@end

@implementation UniPageEventSet

- (NSMutableDictionary<NSString*,UniPageEventObject *>*)eventObjectMap {
    if (_eventObjectMap == nil) {
        _eventObjectMap = [NSMutableDictionary new];
    }
    
    return _eventObjectMap;
}

- (void)dealloc {
}

@end

////////////////////////////////////////////////////

@interface NSObject (UniPageMsgCenter)
@property (nonatomic, strong) UniPageEventSet *eventSet;
@end

static char UniPageEventSetKey;
@implementation NSObject (UniPageMsgCenter)

- (void)setEvSet:(UniPageEventSet *)eventSet {
    objc_setAssociatedObject(self, &UniPageEventSetKey, eventSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UniPageEventSet *)evSet {
    UniPageEventSet *eventSet = objc_getAssociatedObject(self, &UniPageEventSetKey);
    if (!eventSet) {
        eventSet = [[UniPageEventSet alloc] init];
        [self setEvSet:eventSet];
    }
    return eventSet;
}

@end

////////////////////////////////////////////////////

@interface UniPageMsgCenter ()
@property (nonatomic, strong) NSMapTable<NSString *,UniPageEventSet *> *mapTable;
@end

@implementation UniPageMsgCenter

+ (instancetype)defaultCenter {
    static UniPageMsgCenter *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (sharedInstance == nil) {
            sharedInstance = [[self alloc] init];
        }
    });
    return sharedInstance;
}

- (void)addEvent:(UniPageMsgEvent)event observer:(NSObject *)observer {
    if (!event) {
        return;
    }
    if (!observer) {
        return;
    }

    ExecOnMainQueue((^{
        NSString *observerKey = [NSString stringWithFormat:@"%p", observer.evSet];
        NSMapTable *msgDict = self.mapTable;
        UniPageEventSet *eventSet = [self.mapTable objectForKey:observerKey];
        if (!eventSet) {
            eventSet = observer.evSet;
            [msgDict setObject:eventSet forKey:observerKey];
        }
        UniPageEventObject *eventObj = [[UniPageEventObject alloc] init];
        eventObj.eventHandler = event;
        [eventSet.eventObjectMap setObject:eventObj forKey:kUniPageSubscribeLifeCycle];
    }));
}

- (void)postMessage:(id)info {
    ExecOnMainQueue(^{
        NSMapTable *msgDict = self.mapTable;
        for (NSString *obsKey in self.mapTable) {
            UniPageEventSet *eventSet = [msgDict objectForKey:obsKey];
            UniPageEventObject *eventObj = [eventSet.eventObjectMap objectForKey:kUniPageSubscribeLifeCycle];
            eventObj.eventHandler(info);
        }
    });
}

- (void)removeObserver:(NSObject *)observer {
    ExecOnMainQueue((^{
        NSMapTable *msgDic = self.mapTable;
        NSString *observerKey = [NSString stringWithFormat:@"%p", observer.evSet];
        UniPageEventSet *eventSet = [msgDic objectForKey:observerKey];
        [eventSet.eventObjectMap removeAllObjects];
        [msgDic removeObjectForKey:observerKey];
    }));
}

#pragma mark - Getter

- (NSMapTable<NSString *,UniPageEventSet *> *)mapTable {
    if (_mapTable == nil) {
        _mapTable = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory];
    }
    return _mapTable;
}

@end
