package com.zkty.nativ.media.cameraImpl.task;

import android.content.Context;


import com.zkty.nativ.media.cameraImpl.data.MediaFile;
import com.zkty.nativ.media.cameraImpl.listener.MediaLoadCallback;
import com.zkty.nativ.media.cameraImpl.loader.MediaHandler;
import com.zkty.nativ.media.cameraImpl.loader.VideoScanner;

import java.util.ArrayList;

public class VideoLoadTask implements Runnable {

    private Context mContext;
    private VideoScanner mVideoScanner;
    private MediaLoadCallback mMediaLoadCallback;

    public VideoLoadTask(Context context, MediaLoadCallback mediaLoadCallback) {
        this.mContext = context;
        this.mMediaLoadCallback = mediaLoadCallback;
        mVideoScanner = new VideoScanner(context);
    }

    @Override
    public void run() {

        //存放所有视频
        ArrayList<MediaFile> videoFileList = new ArrayList<>();

        if (mVideoScanner != null) {
            videoFileList = mVideoScanner.queryMedia();
        }

        if (mMediaLoadCallback != null) {
            mMediaLoadCallback.loadMediaSuccess(MediaHandler.getVideoFolder(mContext, videoFileList));
        }


    }

}
