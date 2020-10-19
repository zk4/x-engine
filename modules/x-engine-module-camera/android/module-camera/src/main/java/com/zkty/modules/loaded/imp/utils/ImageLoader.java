package com.zkty.modules.loaded.imp.utils;

import android.widget.ImageView;

import java.io.Serializable;

public interface ImageLoader extends Serializable {

    /**
     * 缩略图加载方案
     *
     * @param imageView
     * @param imagePath
     */
    void loadImage(ImageView imageView, String imagePath);

    /**
     * 大图加载方案
     *
     * @param imageView
     * @param imagePath
     */
    void loadPreImage(ImageView imageView, String imagePath);


    /**
     * 视频播放方案
     *
     * @param imageView
     * @param path
     */
//    void loadVideoPlay(ImageView imageView, String path);

    /**
     * 缓存管理
     */
    void clearMemoryCache();

}
