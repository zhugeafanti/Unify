// =================================================
// Autogenerated from Unify 3.0.2, do not edit directly.
// =================================================

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
  设备信息 实体类
*/
@interface DeviceInfoModel : NSObject

@property(nonatomic, copy) NSString* osVersion; // 系统版本 Origin dart type is 'String'
@property(nonatomic, copy) NSString* memory; // 内存信息 Origin dart type is 'String'
@property(nonatomic, copy) NSString* plaform; // 手机型号 Origin dart type is 'String'

+ (DeviceInfoModel*)fromMap:(NSDictionary<NSString*, NSObject*>*)dict;
+ (NSArray<DeviceInfoModel*>*)modelList:(NSArray<NSDictionary<NSObject*, NSObject*>*>*)list;
+ (NSArray<NSDictionary<NSObject*, NSObject*>*>*)dicList:(NSArray<DeviceInfoModel*>*)list;

- (NSDictionary<NSString*, NSObject*>*)toMap;

@end

NS_ASSUME_NONNULL_END
