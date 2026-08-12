import 'package:unify_flutter/api/api.dart';
import 'location_info_model.dart';

@UniFlutterModule()
abstract class LocationInfoService {
  /// 更新定位信息
  void updateLocationInfo(LocationInfoModel model);
  int test(bool st);
  bool test2(double st);
  String test3(int st);
  int? test4(int st);

  Future<int> test5(Map<String, int> st);
}
