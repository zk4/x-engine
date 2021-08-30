package com.zkty.nativ.share;

import android.graphics.Bitmap;

import com.zkty.nativ.share.dto.ShareImg;
import com.zkty.nativ.share.dto.ShareLink;
import com.zkty.nativ.share.dto.ShareMiniProgram;
import com.zkty.nativ.share.dto.ShareText;

import java.util.List;
import java.util.Map;

public interface Ishare {

    List<String> channels();


//    void share(String channel, String type, String text, String title, String desc, String imgUrl, String imgData, Bitmap imgBitmap, String url
//            , String userName, String path, String link, int miniProgramType);
//
//    void share(String channel, String type, Map<String, String> info);


    void share(String channel, ShareText info, CallBack callBack);

    void share(String channel, ShareImg info, CallBack callBack);

    void share(String channel, ShareLink info, CallBack callBack);

    void share(ShareMiniProgram info, CallBack callBack);


    interface CallBack {
        void onResult(int code);
    }


}
