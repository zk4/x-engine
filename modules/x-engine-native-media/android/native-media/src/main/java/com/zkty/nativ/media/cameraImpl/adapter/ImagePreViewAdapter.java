package com.zkty.nativ.media.cameraImpl.adapter;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;

import androidx.annotation.NonNull;
import androidx.viewpager.widget.PagerAdapter;

import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.media.cameraImpl.data.MediaFile;
import com.zkty.nativ.media.cameraImpl.manager.ConfigManager;
import com.zkty.nativ.media.cameraImpl.view.PinchImageView;

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
            imageView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    if(mOnClickListener != null){
                        mOnClickListener.onClick(v);
                    }
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
        container.addView(imageView);
        return imageView;
    }
    /**
     * 外界点击事件
     *
     * @see #setOnSingleClickListener(View.OnClickListener)
     */
    private View.OnClickListener mOnClickListener;
    public void setOnSingleClickListener(View.OnClickListener l) {
        //默认的click会在任何点击情况下都会触发，所以搞成自己的
        mOnClickListener = l;
    }

    @Override
    public void destroyItem(@NonNull ViewGroup container, int position, @NonNull Object object) {
        PinchImageView imageView = (PinchImageView) object;
        container.removeView(imageView);
        viewCache.add(imageView);
    }
}
