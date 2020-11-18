package com.zkty.modules.engine.imp;

import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.zkty.modules.engine.imp.utils.ImageLoader;


public class GlideLoader implements ImageLoader {

    @Override
    public void loadImage(ImageView imageView, String imagePath) {
        Glide.with(imageView.getContext()).load(imagePath).into(imageView);
    }


    @Override
    public void loadPreImage(ImageView imageView, String imagePath) {
        Glide.with(imageView.getContext()).load(imagePath).into(imageView);
    }

    @Override
    public void clearMemoryCache() {

    }
}
