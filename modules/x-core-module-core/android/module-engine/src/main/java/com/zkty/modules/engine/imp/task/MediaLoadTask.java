package com.zkty.modules.engine.imp.task;

import android.content.Context;


import com.zkty.modules.engine.imp.data.MediaFile;
import com.zkty.modules.engine.imp.listener.MediaLoadCallback;
import com.zkty.modules.engine.imp.loader.ImageScanner;
import com.zkty.modules.engine.imp.loader.MediaHandler;
import com.zkty.modules.engine.imp.loader.VideoScanner;

import java.util.ArrayList;

public class MediaLoadTask implements Runnable {

    private Context mContext;
    private ImageScanner mImageScanner;
    private VideoScanner mVideoScanner;
    private MediaLoadCallback mMediaLoadCallback;

    public MediaLoadTask(Context context, MediaLoadCallback mediaLoadCallback) {
        this.mContext = context;
        this.mMediaLoadCallback = mediaLoadCallback;
        mImageScanner = new ImageScanner(context);
        mVideoScanner = new VideoScanner(context);
    }

    @Override
    public void run() {
        //存放所有照片
        ArrayList<MediaFile> imageFileList = new ArrayList<>();
        //存放所有视频
        ArrayList<MediaFile> videoFileList = new ArrayList<>();

        if (mImageScanner != null) {
            imageFileList = mImageScanner.queryMedia();
        }
        if (mVideoScanner != null) {
            videoFileList = mVideoScanner.queryMedia();
        }

        if (mMediaLoadCallback != null) {
            mMediaLoadCallback.loadMediaSuccess(MediaHandler.getMediaFolder(mContext, imageFileList, videoFileList));
        }

    }

}
