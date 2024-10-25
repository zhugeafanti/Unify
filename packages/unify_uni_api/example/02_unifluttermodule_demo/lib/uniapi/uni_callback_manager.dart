// =================================================
// Autogenerated from Unify 3.0.1, do not edit directly.
// =================================================

import '../location_info_model.dart';

import 'caches.dart';
import 'uni_callback.dart';
import 'package:flutter/services.dart';

class UniCallbackManager {
  static UniCallbackManager? _instance;
  static late BasicMessageChannel _channel;
  static late BasicMessageChannel _disposeChannel;

  static UniCallbackManager getInstance() {
    _instance ??= UniCallbackManager._internal();
    return _instance!;
  }

  UniCallbackManager._internal() {
    _channel = BasicMessageChannel<Object?>(
        'com.didi.flutter.uni_api.UniCallbackManager.callback_channel.uf',
        StandardMessageCodec()
    );
    _channel.setMessageHandler((event) async {
      print('onEvent ' + event.toString());
      String callbackName = event['callbackName'];
      Object data = event['data'];
      List<UniCallback> callbacks = [];
      callbacks.addAll(uniCallbackCache.values);
      for (final callback in callbacks) {
        if (callback.callbackName != callbackName) continue;
        UniCallbackDisposable disposable = UniCallbackDisposable(callback);
        if (callback.getType() == LocationInfoModel) {
            (callback as UniCallback<LocationInfoModel>).onEvent(LocationInfoModel.decode(data), disposable);
            continue;
        }

        if (callback.getType() == int) {
          (callback as UniCallback<int>).onEvent(data as int, disposable);
          continue;
        }
        
        if (callback.getType() == String) {
          (callback as UniCallback<String>).onEvent(data as String, disposable);
          continue;
        }

        if (callback.getType().toString() == 'void') {
          callback.onEvent(data, disposable);
          continue;
        }

        if (callback.getType() == bool) {
          (callback as UniCallback<bool>).onEvent(data as bool, disposable);
          continue;
        }

        if (callback.getType() == List) {
          (callback as UniCallback<List>).onEvent(data as List, disposable);
          continue;
        }
        
        if (callback.getType() == Map) {
          (callback as UniCallback<Map>).onEvent(data as Map, disposable);
          continue;
        }        
      }
    });

    _disposeChannel = const BasicMessageChannel<Object?>(
        'com.didi.flutter.uni_api.UniCallbackManager.callback_channel.dispose_.uf',
        StandardMessageCodec());
  }

  void syncDispose(Map<String, dynamic> params) {
    _disposeChannel.send(params);
  }
}

