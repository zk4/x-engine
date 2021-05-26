package com.zkty.nativ.network.utils;

import android.util.Log;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


public class GsonUtil {
    private static final Gson gson = new Gson();

    /**
     * 转成Json字符串
     */
    public static String toJson(Object object) {
        return gson.toJson(object);
    }

    /**
     * Json转Java对象
     */
    public static <T> T fromJson(String json, Class<T> clz) {
            try {
                return gson.fromJson(json, clz);
            }catch (Exception e){
                Log.e("Exception",e.toString());
            }
        return null;
    }

    /**
     * Json转List集合
     */
    public static <T> List<T> jsonToList(String json, Class<T> clz) {
        Type type = new TypeToken<List<T>>() {
        }.getType();
        return gson.fromJson(json, type);
    }

    /**
     * Json转List集合,遇到解析不了的，就使用这个
     */
    public static <T> List<T> fromJsonList(String json, Class<T> cls) {
        List<T> mList = new ArrayList<T>();
        try {
            JsonArray array = new JsonParser().parse(json).getAsJsonArray();
            Gson mGson = new Gson();
            for (final JsonElement elem : array) {
                try {
                    mList.add(mGson.fromJson(elem, cls));
                } catch (Exception e) {
                    Log.e("", e.toString());
                }
            }
        } catch (Exception e) {
            Log.e("", e.toString());
        }
        return mList;
    }

    /**
     * Json转换成Map的List集合对象
     */
    public static <T> List<Map<String, T>> toListMap(String json, Class<T> clz) {
        Type type = new TypeToken<List<Map<String, T>>>() {
        }.getType();
        return gson.fromJson(json, type);
    }

    /**
     * Json转Map对象
     */
    public static <T> Map<String, T> toMap(String json) {
//        Type type = new TypeToken<Map<String, T>>() {
//        }.getType();
        return gson.fromJson(json, new TypeToken<Map<String, String>>() {
        }.getType());
    }
}

