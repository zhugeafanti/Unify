String dartUniCallbackContent({bool nullSafty = true, bool isUseCallbackManager = false}) => """
import 'caches.dart';
${isUseCallbackManager ? "import 'uni_callback_manager.dart';" : ''}
class UniCallback<T> {
  String callbackName = '';
  final Function(T event, UniCallbackDisposable disposable) onEvent;
  UniCallbackDisposable${nullSafty ? "?" : ""} disposable;

  UniCallback(this.onEvent);
  
  Type getType() {
    return T;
  }

  void dispose() {
    if (disposable != null) {
      disposable${nullSafty ? "!" : ""}.dispose();
      disposable = null;
    } else {
      uniCallbackCache.remove(callbackName);
    }
  }
}

class UniCallbackDisposable {
  UniCallback${nullSafty ? "?" : ""} callback;
  
  UniCallbackDisposable(this.callback);
  
  void dispose() {
    if (callback != null) {
      ${isUseCallbackManager ? '''UniCallbackManager.getInstance().syncDispose({
        'callback': callback!.callbackName
      });''' : ''}

      uniCallbackCache.remove(callback${nullSafty ? "!" : ""}.callbackName);
      callback = null;
    }
  }
}
""";
