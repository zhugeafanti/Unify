// =================================================
// Autogenerated from Unify 3.0.2, do not edit directly.
// =================================================

package com.example.uninativemodule_demo;

import java.util.HashMap;
import java.util.Map;

public class UDUniAPI {
    public static Map<String, Object> moduleMap = new HashMap<>();

    public static void registerModule(Object module) {
        Class[] interfaces = module.getClass().getInterfaces();
        if (interfaces.length == 0) {
            moduleMap.put(module.getClass().getName(), module);
        } else {
            moduleMap.put(module.getClass().getInterfaces()[0].getName(), module);
        }
    }

    public static<T> T get(Class<T> aClass) {
        return (T) moduleMap.get(aClass.getName());
    }

}
