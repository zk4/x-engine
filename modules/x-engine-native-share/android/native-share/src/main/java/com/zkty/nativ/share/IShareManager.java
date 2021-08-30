package com.zkty.nativ.share;

import android.graphics.Bitmap;

import java.util.Map;

public interface IShareManager {

//    void share(String channel, String type, String text, String title, String desc, String imgUrl, String imgData, Bitmap imgBitmap, String url
//            , String userName, String path, String link, int miniProgramType);

    void share(String channel, String type, Map<String, String> info, Ishare.CallBack callBack);


}
