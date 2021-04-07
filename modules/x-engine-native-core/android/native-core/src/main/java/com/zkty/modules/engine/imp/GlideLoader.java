package com.zkty.modules.engine.imp;

import android.net.Uri;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.zkty.modules.engine.imp.utils.ImageLoader;
import com.zkty.modules.engine.utils.ImageUtils;


public class GlideLoader implements ImageLoader {

    @Override
    public void loadImage(ImageView imageView, String imagePath) {
        Uri uri = ImageUtils.getMediaUriFromPath(imageView.getContext(),imagePath);
        Glide.with(imageView.getContext()).load(uri).into(imageView);
    }


    @Override
    public void loadPreImage(ImageView imageView, String imagePath) {
        Uri uri = ImageUtils.getMediaUriFromPath(imageView.getContext(),imagePath);
        Glide.with(imageView.getContext()).load(uri).into(imageView);
    }

    @Override
    public void clearMemoryCache() {

    }
}
