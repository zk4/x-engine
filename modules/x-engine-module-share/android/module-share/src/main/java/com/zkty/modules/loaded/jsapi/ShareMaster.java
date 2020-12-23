package com.zkty.modules.loaded.jsapi;

import android.app.Activity;
import android.app.Application;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.text.TextUtils;

import com.bumptech.glide.Glide;
import com.bumptech.glide.util.Util;
import com.tencent.mm.opensdk.modelmsg.SendMessageToWX;
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage;
import com.tencent.mm.opensdk.modelmsg.WXMusicObject;
import com.tencent.mm.opensdk.modelmsg.WXVideoObject;
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;
import com.zkty.modules.engine.XEngineApplication;
import com.zkty.modules.engine.utils.ImageUtils;

import java.io.ByteArrayOutputStream;
import java.util.concurrent.ExecutionException;

import module.share.R;


public class ShareMaster {


    public static void share(Context context, String channel, String type, String title, String desc, String link, String imgUrl, String dataUrl) {


        switch (channel) {
            case "wx_friend":
            case "wx_zone":
                decodeImageAndShareToWx(context, channel, type, title, desc, link, imgUrl, dataUrl);
                break;

        }


    }

    private static void decodeImageAndShareToWx(Context context, String channel, String type, String title, String desc, String link, String imgUrl, String dataUrl) {
        if (TextUtils.isEmpty(imgUrl)) {
            shareToWx(context, channel, type, title, desc, link, null, dataUrl);
        } else {
            new Thread() {
                @Override
                public void run() {
                    Bitmap bitmap = null;
                    try {
                        bitmap = Glide.with(context)
                                .asBitmap()
                                .load(imgUrl)
                                .into(150, 150).get();
                        if (bitmap != null) {
                            ByteArrayOutputStream stream = new ByteArrayOutputStream();
                            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
                            byte[] imageByte = stream.toByteArray();

                            ((Activity) context).runOnUiThread(() -> shareToWx(context, channel, type, title, desc, link, imageByte, dataUrl));

                        }

                    } catch (Exception e) {
                        ((Activity) context).runOnUiThread(() -> shareToWx(context, channel, type, title, desc, link, null, dataUrl));
                    }
                }
            }.start();

        }


    }

    private static void shareToWx(Context context, String channel, String type, String title, String desc, String link, byte[] thumbBmp, String dataUrl) {

        int mTargetScene = SendMessageToWX.Req.WXSceneSession;
        if ("wx_friend".equals(channel)) {
            mTargetScene = SendMessageToWX.Req.WXSceneSession;
        } else if ("wx_zone".equals(channel)) {
            mTargetScene = SendMessageToWX.Req.WXSceneTimeline;
        }


        String appId = null;
        try {
            ApplicationInfo appInfo = context.getPackageManager().getApplicationInfo(context.getPackageName(), PackageManager.GET_META_DATA);
            if (appInfo.metaData != null) {
                for (String key : appInfo.metaData.keySet()) {
                    if (!TextUtils.isEmpty(key) && ("wx_appid").equals(key)) {
                        appId = appInfo.metaData.getString(key);
                        break;
                    }
                }
            }

        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        if (TextUtils.isEmpty(appId)) return;

        IWXAPI api = WXAPIFactory.createWXAPI(context, appId);


        switch (type) {
            case "music":

                WXMusicObject music = new WXMusicObject();
                music.musicUrl = dataUrl;

//用 WXMusicObject 对象初始化一个 WXMediaMessage 对象
                WXMediaMessage msg = new WXMediaMessage();
                msg.mediaObject = music;
                msg.title = title;
                msg.description = desc;
//                Bitmap thumbBmp = BitmapFactory.decodeResource(getResources(), R.drawable.send_music_thumb);
//设置音乐缩略图
                msg.thumbData = thumbBmp;

//构造一个Req
                SendMessageToWX.Req req = new SendMessageToWX.Req();
//                req.transaction = buildTransaction("music");
                req.message = msg;
                req.scene = mTargetScene;
//                req.userOpenId = getOpenId();
                //调用api接口，发送数据到微信
                api.sendReq(req);


                break;
            case "video":

                //初始化一个WXVideoObject，填写url
                WXVideoObject video = new WXVideoObject();
                video.videoUrl = dataUrl;

//用 WXVideoObject 对象初始化一个 WXMediaMessage 对象
                WXMediaMessage msg2 = new WXMediaMessage(video);
                msg2.title = title;
                msg2.description = desc;
//                Bitmap thumbBmp = BitmapFactory.decodeResource(getResources(), R.drawable.send_music_thumb);
//                msg2.thumbData =Util.bmpToByteArray(thumbBmp,true);
                msg2.thumbData = thumbBmp;
//构造一个Req
                SendMessageToWX.Req req2 = new SendMessageToWX.Req();
//                req2.transaction = buildTransaction("video");
                req2.message = msg2;
                req2.scene = mTargetScene;
//                req2.userOpenId = getOpenId();

//调用api接口，发送数据到微信
                api.sendReq(req2);


                break;


            case "link":
            default:

                //初始化一个WXWebpageObject，填写url
                WXWebpageObject webpage = new WXWebpageObject();
                webpage.webpageUrl = link;

                //用 WXWebpageObject 对象初始化一个 WXMediaMessage 对象
                WXMediaMessage msg3 = new WXMediaMessage(webpage);
                msg3.title = title;
                msg3.description = desc;
//                Bitmap thumbBmp = BitmapFactory.decodeResource(getResources(), R.drawable.send_music_thumb);
                msg3.thumbData = thumbBmp;

                //构造一个Req
                SendMessageToWX.Req req3 = new SendMessageToWX.Req();
//                req.transaction = buildTransaction("webpage");
                req3.message = msg3;
                req3.scene = mTargetScene;
//                req.userOpenId = getOpenId();

                //调用api接口，发送数据到微信
                api.sendReq(req3);
                break;

        }


    }
}
