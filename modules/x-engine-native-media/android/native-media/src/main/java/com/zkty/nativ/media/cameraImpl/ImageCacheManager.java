package com.zkty.nativ.media.cameraImpl;

import android.util.LruCache;

/**
 * @author : MaJi
 * @time : (8/19/21)
 * dexc :
 */
public class ImageCacheManager {


    private static LruCache<String,String> cache =  new LruCache<String,String>(20);


    public static void put(String key,String value){
        cache.put(key,value);
    }

    public static String get(String key){
        String value = cache.get(key);
        return value;
    }

    public static void clear(){
        cache.evictAll();
    }



}
