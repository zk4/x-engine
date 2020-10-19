package com.zkty.modules.loaded.imp.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.viewpager.widget.PagerAdapter;

import com.zkty.modules.loaded.imp.data.MediaFile;
import com.zkty.modules.loaded.imp.manager.ConfigManager;
import com.zkty.modules.loaded.imp.view.PinchImageView;

import java.util.LinkedList;
import java.util.List;

public class ImagePreViewAdapter extends PagerAdapter {

    private Context mContext;
    private List<MediaFile> mMediaFileList;

    LinkedList<PinchImageView> viewCache = new LinkedList<PinchImageView>();

    public ImagePreViewAdapter(Context context, List<MediaFile> mediaFileList) {
        this.mContext = context;
        this.mMediaFileList = mediaFileList;
    }

    @Override
    public int getCount() {
        return mMediaFileList == null ? 0 : mMediaFileList.size();
    }

    @Override
    public boolean isViewFromObject(@NonNull View view, @NonNull Object object) {
        return view == object;
    }

    @NonNull
    @Override
    public Object instantiateItem(@NonNull ViewGroup container, int position) {
        PinchImageView imageView;
        if (viewCache.size() > 0) {
            imageView = viewCache.remove();
            imageView.reset();
        } else {
            imageView = new PinchImageView(mContext);
        }
        try {
            ConfigManager.getInstance().getImageLoader().loadPreImage(imageView, mMediaFileList.get(position).getPath());
        } catch (Exception e) {
            e.printStackTrace();
        }
        container.addView(imageView);
        return imageView;
    }

    @Override
    public void destroyItem(@NonNull ViewGroup container, int position, @NonNull Object object) {
        PinchImageView imageView = (PinchImageView) object;
        container.removeView(imageView);
        viewCache.add(imageView);
    }
}
