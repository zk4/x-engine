package com.zkty.nativ.media2.cameraImpl.task;

import android.content.Context;

import com.zkty.nativ.media2.cameraImpl.data.MediaFile;
import com.zkty.nativ.media2.cameraImpl.listener.MediaLoadCallback;
import com.zkty.nativ.media2.cameraImpl.loader.ImageScanner;
import com.zkty.nativ.media2.cameraImpl.loader.MediaHandler;

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
