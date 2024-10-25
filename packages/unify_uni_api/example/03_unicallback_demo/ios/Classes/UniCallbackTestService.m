// =================================================
// Autogenerated from Unify 3.0.1, do not edit directly.
// =================================================

#import "UniCallbackTestService.h"
#import <Flutter/Flutter.h>

#import "LocationInfoModel.h"

@interface OnDoCallbackAction0Callback ()

@property(nonatomic, weak) id<FlutterBinaryMessenger> binaryMessenger; // Origin dart type is 'id'

@end

@interface OnDoCallbackAction1Callback ()

@property(nonatomic, weak) id<FlutterBinaryMessenger> binaryMessenger; // Origin dart type is 'id'

@end


@implementation OnDoCallbackAction0Callback

- (void)onEvent:(LocationInfoModel*)callback {
    // 参数判空检查
    if (callback == NULL) {
        return;
    }
    FlutterBasicMessageChannel *channel =
        [FlutterBasicMessageChannel
            messageChannelWithName:@"com.didi.flutter.uni_api.UniCallbackManager.callback_channel.uf"
            binaryMessenger:self.binaryMessenger];
    NSDictionary *msg = @{@"callbackName":self.callbackName,@"data":callback.toMap};
    // 发送消息
    [channel sendMessage:msg];
}

@end

@implementation OnDoCallbackAction1Callback

- (void)onEvent {
    FlutterBasicMessageChannel *channel =
        [FlutterBasicMessageChannel
            messageChannelWithName:@"com.didi.flutter.uni_api.UniCallbackManager.callback_channel.uf"
            binaryMessenger:self.binaryMessenger];
    NSDictionary *msg = @{@"callbackName":self.callbackName,@"data" : @""};
    // 发送消息
    [channel sendMessage:msg];
}

@end


static NSDictionary * mapClone(NSDictionary *dic);
static NSArray * listClone(NSArray *list) {
    NSMutableArray *newList = NSMutableArray.new;
    if ([list isKindOfClass:[NSNull class]]) return [newList copy];
    for (id value in list) {
        [newList addObject:
            [value isKindOfClass:[NSArray class]]? listClone(value) :
            [value isKindOfClass:[NSDictionary class]]?mapClone(value) :
            [value isKindOfClass:[LocationInfoModel class]]? [value toMap] :
            value];
    }
  
    return [newList copy];
}
    
static NSDictionary * mapClone(NSDictionary *dic) {
  NSMutableDictionary *newDic = NSMutableDictionary.new;
  if ([dic isKindOfClass:[NSNull class]]) return [newDic copy];
  for (id key in dic) {
      id value = [dic objectForKey:key];
      newDic[key] =
          [value isKindOfClass:[NSArray class]]? listClone(value) :
          [value isKindOfClass:[NSDictionary class]]? mapClone(value) :
          [value isKindOfClass:[LocationInfoModel class]]? [value toMap] :
          value;
  }
  return  [newDic copy];;
}
    
static NSDictionary * mapConvert(NSDictionary *dic, NSArray *generics, int depth);
static NSArray * listConvert(NSArray *list, NSArray *generics, int depth) {
        NSMutableArray *newList = NSMutableArray.new;
        if ([list isKindOfClass:[NSNull class]]) return [newList copy];
        for (id value in list) {
            [newList addObject:
                [generics[depth] isEqual:@"NSArray"]? listConvert(value, generics, depth+1) :
                [generics[depth] isEqual:@"NSDictionary"]? mapConvert(value, generics, depth+1) :
                [generics[depth] isEqual:@"LocationInfoModel"]? [LocationInfoModel fromMap: value] :
                value];
        }
      
        return [newList copy];
}

static NSDictionary * mapConvert(NSDictionary *dic, NSArray *generics, int depth) {
  NSMutableDictionary *newDic = NSMutableDictionary.new;
  if ([dic isKindOfClass:[NSNull class]]) return [newDic copy];
  for (id key in dic) {
      id value = [dic objectForKey:key];
      newDic[key] =
      [generics[depth] isEqual:@"NSArray"]? listConvert(value, generics, depth+1) :
      [generics[depth] isEqual:@"NSDictionary"]? mapConvert(value, generics, depth+1) :
      [generics[depth] isEqual:@"LocationInfoModel"]? [LocationInfoModel fromMap: value] :
      value;
  }
  return  [newDic copy];;
}

static NSDictionary<NSString*, id>* wrapResult(NSObject* result, FlutterError* error) {
    NSDictionary *errorDict = (NSDictionary *)[NSNull null];
    if (error) {
        errorDict = @{
            @"code": (error.code ? error.code : [NSNull null]),
            @"message": (error.message ? error.message : [NSNull null]),
            @"details": (error.details ? error.details : [NSNull null]),
            };
    }
    return @{
        @"result": (result ? result : [NSNull null]),
        @"error": errorDict,
        };
}

void UniCallbackTestServiceSetup(id<FlutterBinaryMessenger> binaryMessenger, id<UniCallbackTestService> api) {
    {
        FlutterBasicMessageChannel *channel =
            [FlutterBasicMessageChannel
                messageChannelWithName:@"com.didi.flutter.uni_api.UniCallbackTestService.doCallbackAction0"
                binaryMessenger:binaryMessenger];
        if (api) {
            [channel setMessageHandler:^(id _Nullable message, FlutterReply reply) {
                NSString *callbackName = [message objectForKey:@"callback"];
                OnDoCallbackAction0Callback *callback = OnDoCallbackAction0Callback.new;
                callback.callbackName = callbackName;
                callback.binaryMessenger = binaryMessenger;
                [UFUniCallbackDispatcher registe:callbackName callback:callback];
                FlutterError *error;
                [api doCallbackAction0:callback error:&error];
                reply(wrapResult(nil, error));
            }];
        } else {
            [channel setMessageHandler:nil];
        }
    }
    {
        FlutterBasicMessageChannel *channel =
            [FlutterBasicMessageChannel
                messageChannelWithName:@"com.didi.flutter.uni_api.UniCallbackTestService.doCallbackAction1"
                binaryMessenger:binaryMessenger];
        if (api) {
            [channel setMessageHandler:^(id _Nullable message, FlutterReply reply) {
                NSString *callbackName = [message objectForKey:@"callback"];
                OnDoCallbackAction1Callback *callback = OnDoCallbackAction1Callback.new;
                callback.callbackName = callbackName;
                callback.binaryMessenger = binaryMessenger;
                [UFUniCallbackDispatcher registe:callbackName callback:callback];
                FlutterError *error;
                [api doCallbackAction1:callback error:&error];
                reply(wrapResult(nil, error));
            }];
        } else {
            [channel setMessageHandler:nil];
        }
    }
}
