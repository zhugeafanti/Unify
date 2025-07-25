// =================================================
// Autogenerated from Unify 3.0.2, do not edit directly.
// =================================================

#import <Foundation/Foundation.h>

@protocol FlutterBinaryMessenger;
@class FlutterError;
@class DeviceInfoModel;

NS_ASSUME_NONNULL_BEGIN

/*
 Call flow direction : dart -> native
*/
@protocol DeviceInfoService


/*
  获取设备信息
*/
- (void)getDeviceInfo:(void(^)(DeviceInfoModel* result))success fail:(void(^)(FlutterError* error))fail;

@end

extern void DeviceInfoServiceSetup(id<FlutterBinaryMessenger> binaryMessenger, id<DeviceInfoService> api);

NS_ASSUME_NONNULL_END
