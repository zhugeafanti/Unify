// =================================================
// Autogenerated from Unify 3.0.1, do not edit directly.
// =================================================

package com.example.unifluttermodule_demo;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import com.example.unifluttermodule_demo.UFUniAPI;
import com.example.unifluttermodule_demo.LocationInfoModel;

/*
 Call flow direction : native -> dart
*/
public class LocationInfoService {
    private BinaryMessenger messenger;


    private static List<Object> listClone(List list) {
      List newList = new ArrayList<>();
      for (Object value: list) {
          newList.add(
            value instanceof Map ? mapClone((Map<String, Object>) value) :
            value instanceof List ? listClone((List<Object>) value) :
            value instanceof LocationInfoModel ? ((LocationInfoModel) value).toMap() :
            value
          );
      }
      return newList;
    }
    
    private static  Map<String, Object> mapClone(Map<String, Object> map) {
      Map<String, Object> newDic = new HashMap<String, Object>();
      for(Map.Entry<String, Object> entry : map.entrySet()) {
          Object value = entry.getValue();
          String key = entry.getKey();
          newDic.put(key,
          value instanceof Map ? mapClone((Map<String, Object>) value):
          value instanceof List? listClone((List<Object>) value) :
          value instanceof LocationInfoModel ? ((LocationInfoModel) value).toMap() :
          value);
      }
      return newDic;
    }
    
    private static List listConvert(List list, String[] generics, int depth) {
      List newList = new ArrayList<>();
      for (Object value : list) {
          newList.add(
              generics[depth] == "List" ? listConvert((List<Object>)value, generics, depth+1) :
              generics[depth] == "Map" ? mapConvert((Map<String, Object>)value, generics, depth+1) :
              generics[depth] == "LocationInfoModel" ? LocationInfoModel.fromMap((Map<String, Object>)value) :
              value);
      }
    
      return newList;
    }

    private static Map<String, Object> mapConvert(Map<String, Object> map, String[] generics, int depth) {
      Map<String, Object> newDic = new HashMap<String, Object>();
      for(Map.Entry<String, Object> entry : map.entrySet()) {
          Object value = entry.getValue();
          String key = entry.getKey();
          newDic.put(key,
          generics[depth] == "List" ? listConvert((List<Object>)value, generics, depth+1) :
          generics[depth] == "Map" ? mapConvert((Map<String, Object>)value, generics, depth+1) :
          generics[depth] == "LocationInfoModel" ? LocationInfoModel.fromMap((Map<String, Object>)value) :
          value);
      }
      return  newDic;
    }
    
    public void setup(BinaryMessenger messenger) {
        this.messenger = messenger;
        UFUniAPI.registerModule(this);
    }

    public interface Result<T> {
        void result(T result);

    }

    public void updateLocationInfo(LocationInfoModel model) {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(messenger, "com.didi.flutter.uni_api.LocationInfoService.updateLocationInfo", new StandardMessageCodec());
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("model", model.toMap());
        channel.send(parameters);
    }
}
