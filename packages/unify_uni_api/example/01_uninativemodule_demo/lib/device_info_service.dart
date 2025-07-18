// =================================================
// Autogenerated from Unify 3.0.2, do not edit directly.
// =================================================

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'uniapi/uni_api.dart';

import 'device_info_model.dart';

/// Call flow direction : dart -> native
class DeviceInfoService {
    static Map<K, dynamic> mapClone<K, V>(Map<K, V> map) {
      Map<K, dynamic> newMap = <K, dynamic>{};

      map.forEach((key, value) {
        newMap[key] = 
          (value is Map ? mapClone(value) : 
          value is List ? listClone(value): 
          value is DeviceInfoModel ? value.encode() : 
          value);
      });

      return newMap;
    }
    
    static List<T> listClone<T>(List list) {
      List<T> newList = <T>[];
      for (var value in list) {
        newList.add(
          value is Map ? mapClone(value) :
          value is List ? listClone(value) :
          value is DeviceInfoModel ? value.encode() : 
          value);
      }

      return newList;
    }
    

    static Future<DeviceInfoModel> getDeviceInfo() async  {
        const BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?> (
            'com.didi.flutter.uni_api.DeviceInfoService.getDeviceInfo', StandardMessageCodec());
        final Map<Object?, Object?>? replyMap =
            await channel.send(null) as Map<Object?, Object?>?;
        if (replyMap == null) {
            UniApi.trackError('DeviceInfoService', 'com.didi.flutter.uni_api.DeviceInfoService.getDeviceInfo', 'Unable to establish connection on channel : "com.didi.flutter.uni_api.DeviceInfoService.getDeviceInfo" .');
            if (!kReleaseMode) {
                throw PlatformException(
                    code: 'channel-error',
                    message: 'Unable to establish connection on channel : "com.didi.flutter.uni_api.DeviceInfoService.getDeviceInfo" .',
                    details: null,
                );
            }
        } else if (replyMap['error'] != null) {
            final Map<Object?, Object?> error = (replyMap['error']  as Map<Object?, Object?>);
            String errorMsg = '';
            if (error.containsKey('code')) errorMsg += '[ ${error['code']?.toString() ?? ''} ]';
            if (error.containsKey('message')) errorMsg += '[ ${error['message']?.toString() ?? ''} ]';
            if (error.containsKey('details')) errorMsg += '[ ${error['details']?.toString() ?? ''} ]';
            UniApi.trackError('DeviceInfoService', 'com.didi.flutter.uni_api.DeviceInfoService.getDeviceInfo', 'getDeviceInfo: $errorMsg);');
            if (!kReleaseMode) {
                throw PlatformException(
                    code: error['code'] as String,
                    message: error['message'] as String,
                    details: error['details'],
                );
            }
        } else {
            return DeviceInfoModel.decode(replyMap['result']!);
        }
        throw Exception('方法 "getDeviceInfo" : 返回类型错误!');
    }

}
