package com.zkty.modules.loaded.util;

import android.content.Context;
import android.content.SharedPreferences;
import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.tencent.mmkv.MMKV;
import com.zkty.modules.engine.core.MicroAppLoader;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import java.net.MalformedURLException;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SharePreferenceUtils {

    /**
     * 保存数据
     *
     * @param context
     * @param key
     * @param object
     */
    private static final String NAME_SPACE = "x-localstorage";

    public static void put(Context context, Boolean isPublish, String key, Object object) {
        MMKV mmkv = getSp(context, isPublish);
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
     * @param context
     * @param key
     * @param defaultValue
     * @return
     */

    public static Object get(Context context, boolean isPublish, String key, @NonNull Object defaultValue) {
        if (defaultValue == null) {
            return getSp(context, isPublish).decodeString(key, (String) defaultValue);
        } else if (defaultValue instanceof String) {
            return getSp(context, isPublish).decodeString(key, (String) defaultValue);
        } else if (defaultValue instanceof Integer) {
            return getSp(context, isPublish).decodeInt(key, (Integer) defaultValue);
        } else if (defaultValue instanceof Boolean) {
            return getSp(context, isPublish).decodeBool(key, (Boolean) defaultValue);
        } else if (defaultValue instanceof Float) {
            return getSp(context, isPublish).decodeFloat(key, (Float) defaultValue);
        } else if (defaultValue instanceof Long) {
            return getSp(context, isPublish).decodeLong(key, (Long) defaultValue);
        }
        return null;
    }

    /**
     * remove key
     *
     * @param context
     * @param key
     */
    public static void remove(Context context, boolean isPublish, String key) {
        getSp(context, isPublish).removeValueForKey(key);
    }

    /**
     * 判断是否包含key
     *
     * @param context
     * @param key
     * @return
     */
    public static boolean contains(Context context, boolean isPublish, String key) {
        return getSp(context, isPublish).containsKey(key);
    }

    /**
     * 清空数据
     *
     * @param context
     */
    public static void clear(Context context, boolean isPublish) {
        getSp(context, isPublish).clearAll();

    }


    public static MMKV getSp(Context context, boolean isPublish) {
        String namespace;
        if (isPublish) {
            namespace = NAME_SPACE;
        } else {
            namespace = getNamespace();
        }
        return MMKV.mmkvWithID(namespace, MMKV.MULTI_PROCESS_MODE);
    }

    private static String getNamespace() {

        if (XEngineWebActivityManager.sharedInstance().getCurrent() != null) {
            String link = XEngineWebActivityManager.sharedInstance().getCurrent().getWebUrl();
            StringBuilder sb = new StringBuilder();
            if (link.startsWith("http")) {
                Pattern p = Pattern.compile("(?<=//|)((\\w)+\\.)+\\w+");
                Matcher matcher = p.matcher(link);
                if (matcher.find()) {
                    String host = matcher.group();
                    String[] splits = host.split("\\.");
                    for (int i = splits.length - 1; i > -1; i--) {
                        sb.append(splits[i]);
                        if (i > 0) {
                            sb.append(".");
                        }
                    }
                    return sb.toString();
                }
            } else if (!TextUtils.isEmpty(MicroAppLoader.sharedInstance().getCurrentMicroAppId())) {
                return MicroAppLoader.sharedInstance().getCurrentMicroAppId();
            }
        }
        return NAME_SPACE;
    }
}
