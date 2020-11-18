package com.zkty.modules.engine.imp.task;

import android.content.Context;


import com.zkty.modules.engine.imp.data.MediaFile;
import com.zkty.modules.engine.imp.listener.MediaLoadCallback;
import com.zkty.modules.engine.imp.loader.ImageScanner;
import com.zkty.modules.engine.imp.loader.MediaHandler;

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
