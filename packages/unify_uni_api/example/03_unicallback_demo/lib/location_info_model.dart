// =================================================
// Autogenerated from Unify 3.0.1, do not edit directly.
// =================================================


///  定位经纬度信息 实体类
class LocationInfoModel {
    double? lat; /// 纬度
    double? lng; /// 经度

    Object encode() {
        final Map<String, dynamic> ret = <String, dynamic>{};
        ret['lat'] = lat as double?;
        ret['lng'] = lng as double?;
        return ret;
    }

    static LocationInfoModel decode(Object message) {
        final Map<dynamic, dynamic> rawMap = message as Map<dynamic, dynamic>;
        final Map<String, dynamic> map = Map.from(rawMap);
        return LocationInfoModel()
            ..lat = map['lat'] == null
                ? 0.0
                : map['lat'] as double?
            ..lng = map['lng'] == null
                ? 0.0
                : map['lng'] as double?
            ;
    }
}
