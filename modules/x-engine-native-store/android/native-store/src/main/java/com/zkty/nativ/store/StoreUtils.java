package com.zkty.nativ.store;

import androidx.annotation.NonNull;

import com.tencent.mmkv.MMKV;

public class StoreUtils {

    /**
     * 保存数据
     *
     * @param key
     * @param object
     */
    private static final String NAME_SPACE = "x-localstorage";

    public static void put(String key, Object object) {
        if (object == null) return;
        MMKV mmkv = getSp();
        if (object instanceof String) {
            mmkv.encode(key, (String) object);
        } else if (object instanceof Integer) {
            mmkv.encode(key, (Integer) object);
        } else if (object instanceof Boolean) {
            mmkv.encode(key, (Boolean) object);
        } else if (object instanceof Float) {
            mmkv.encode(key, (Float) object);
        } else if (object instanceof Long) {
            mmkv.encode(key, (Long) object);
        } else {
            mmkv.encode(key, object.toString());
        }

    }

    /**
     * 获取数据
     *
     * @param key
     * @param defaultValue
     * @return
     */

    public static Object get(String key, @NonNull Object defaultValue) {
        if (defaultValue == null) {
            return getSp().decodeString(key, (String) defaultValue);
        } else if (defaultValue instanceof String) {
            return getSp().decodeString(key, (String) defaultValue);
        } else if (defaultValue instanceof Integer) {
            return getSp().decodeInt(key, (Integer) defaultValue);
        } else if (defaultValue instanceof Boolean) {
            return getSp().decodeBool(key, (Boolean) defaultValue);
        } else if (defaultValue instanceof Float) {
            return getSp().decodeFloat(key, (Float) defaultValue);
        } else if (defaultValue instanceof Long) {
            return getSp().decodeLong(key, (Long) defaultValue);
        }
        return null;
    }

    /**
     * remove key
     *
     * @param key
     */
    public static void remove(String key) {
        getSp().removeValueForKey(key);
    }

    /**
     * 判断是否包含key
     *
     * @param key
     * @return
     */
    public static boolean contains(String key) {
        return getSp().containsKey(key);
    }

    /**
     * 清空数据
     *
     */
    public static void clear() {
        getSp().clearAll();

    }


    public static MMKV getSp() {

        return MMKV.mmkvWithID(NAME_SPACE, MMKV.MULTI_PROCESS_MODE);
    }

}
