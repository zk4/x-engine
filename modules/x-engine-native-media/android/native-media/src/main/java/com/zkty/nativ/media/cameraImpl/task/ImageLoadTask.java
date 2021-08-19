package com.zkty.nativ.media.cameraImpl.task;

import android.content.Context;


import com.zkty.nativ.media.cameraImpl.data.MediaFile;
import com.zkty.nativ.media.cameraImpl.listener.MediaLoadCallback;
import com.zkty.nativ.media.cameraImpl.loader.ImageScanner;
import com.zkty.nativ.media.cameraImpl.loader.MediaHandler;

import java.util.ArrayList;

public class ImageLoadTask implements Runnable {

    private Context mContext;
    private ImageScanner mImageScanner;
    private MediaLoadCallback mMediaLoadCallback;

    public ImageLoadTask(Context context, MediaLoadCallback mediaLoadCallback) {
        this.mContext = context;
        this.mMediaLoadCallback = mediaLoadCallback;
        mImageScanner = new ImageScanner(context);
    }

    @Override
    public void run() {
        //存放所有照片
        ArrayList<MediaFile> imageFileList = new ArrayList<>();

        if (mImageScanner != null) {
            imageFileList = mImageScanner.queryMedia();
        }

        if (mMediaLoadCallback != null) {
            mMediaLoadCallback.loadMediaSuccess(MediaHandler.getImageFolder(mContext, imageFileList));
        }


    }

}
