package com.zkty.nativ.share_wx;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;
import android.util.Base64;
import android.util.Log;

import com.bumptech.glide.Glide;
import com.bumptech.glide.util.Util;
import com.tencent.mm.opensdk.modelmsg.SendMessageToWX;
import com.tencent.mm.opensdk.modelmsg.WXImageObject;
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage;
import com.tencent.mm.opensdk.modelmsg.WXMiniProgramObject;
import com.tencent.mm.opensdk.modelmsg.WXMusicObject;
import com.tencent.mm.opensdk.modelmsg.WXTextObject;
import com.tencent.mm.opensdk.modelmsg.WXVideoObject;
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;
import com.tencent.mmkv.MMKV;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.share.Ishare;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

import module.share_wx.R;

public class Nativeshare_wx extends NativeModule implements Ishare {

    @Override
    public String moduleId() {
        return "com.zkty.native.share_wx";
    }

    @Override
    public void afterAllNativeModuleInited() {

    }

    @Override
    public List<String> channels() {
        List<String> channels = new ArrayList<>();
        channels.add("wx_zone");
        channels.add("wx_friend");
        return channels;
    }

    @Override
    public void share(String channel, String type, String text, String title, String desc, String imgUrl, String imgData, Bitmap imgBitmap, String url, String userName, String path, String link, int miniProgramType) {
        decodeImageAndShareToWx(XEngineApplication.getCurrentActivity(), channel, type, text, title, desc, imgUrl, imgData, imgBitmap, url, userName, path, link, miniProgramType);

    }

    private static void decodeImageAndShareToWx(Context context, String channel, String type, String text, String title, String desc, String imgUrl, String imgData, Bitmap imgBitmap, String url, String userName, String path, String link, int miniProgramType) {
        if (TextUtils.isEmpty(imgUrl)) {
            shareToWx(context, channel, type, text, title, desc, null, imgData, imgBitmap, url, userName, path, link, miniProgramType);
        } else {
            new Thread() {
                @Override
                public void run() {
                    Bitmap bitmap = null;
                    Handler handler = new Handler(Looper.getMainLooper());
                    try {
                        bitmap = Glide.with(context)
                                .asBitmap()
                                .load(imgUrl)
                                .into(150, 150).get();
                        if (bitmap != null) {
                            ByteArrayOutputStream stream = new ByteArrayOutputStream();
                            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, stream);
                            byte[] imageByte = stream.toByteArray();
                            handler.post(() -> shareToWx(context, channel, type, text, title, desc, imageByte, imgData, imgBitmap, url, userName, path, link, miniProgramType));

                        }

                    } catch (Exception e) {
                        handler.post(() -> shareToWx(context, channel, type, text, title, desc, null, imgData, imgBitmap, url, userName, path, link, miniProgramType));
                    }
                }
            }.start();

        }


    }

    private static void shareToWx(Context context, String channel, String type, String text, String title, String desc, byte[] thumbBmp, String imgData ,Bitmap imgBitmap, String url, String userName, String path, String link, int miniProgramType) {

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
            case "text":
                //初始化一个 WXTextObject 对象，填写分享的文本内容
                WXTextObject textObj = new WXTextObject();
                textObj.text = text;

                //用 WXTextObject 对象初始化一个 WXMediaMessage 对象
                WXMediaMessage msg = new WXMediaMessage();
                msg.mediaObject = textObj;
                msg.description = text;

                SendMessageToWX.Req req = new SendMessageToWX.Req();
                req.message = msg;
                req.scene = mTargetScene;
                //调用api接口，发送数据到微信
                api.sendReq(req);

                break;
            case "img":
                Bitmap bmp = null;
                if (imgBitmap != null) {
                    bmp = imgBitmap;
                }
                else if (!TextUtils.isEmpty(imgData)) {
                    byte[] bytes = Base64.decode(imgData, Base64.DEFAULT);
                    bmp = BitmapFactory.decodeByteArray(bytes, 0, thumbBmp.length);
                }else if (thumbBmp != null) {
                    bmp = BitmapFactory.decodeByteArray(thumbBmp, 0, thumbBmp.length);
                }


//初始化 WXImageObject 和 WXMediaMessage 对象
                WXImageObject imgObj = new WXImageObject(bmp);
                WXMediaMessage msg2 = new WXMediaMessage();
                msg2.mediaObject = imgObj;

//设置缩略图
                bmp.recycle();
                msg2.thumbData = thumbBmp;

//构造一个Req
                SendMessageToWX.Req req2 = new SendMessageToWX.Req();
                req2.message = msg2;
                req2.scene = mTargetScene;
//调用api接口，发送数据到微信
                api.sendReq(req2);

                break;

            case "miniProgram":
                WXMiniProgramObject miniProgramObj = new WXMiniProgramObject();
                miniProgramObj.webpageUrl = link; // 兼容低版本的网页链接
                miniProgramObj.miniprogramType = miniProgramType == 0 ? WXMiniProgramObject.MINIPTOGRAM_TYPE_RELEASE : miniProgramType == 1 ? WXMiniProgramObject.MINIPROGRAM_TYPE_TEST : WXMiniProgramObject.MINIPROGRAM_TYPE_PREVIEW;// 正式版:0，测试版:1，体验版:2
                miniProgramObj.userName = userName;     // 小程序原始id
                miniProgramObj.path = path;            //小程序页面路径；对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"
                WXMediaMessage msg4 = new WXMediaMessage(miniProgramObj);
                msg4.title = title;                    // 小程序消息title
                msg4.description = desc;               // 小程序消息desc
                msg4.thumbData = thumbBmp;                      // 小程序消息封面图片，小于128k

                SendMessageToWX.Req req4 = new SendMessageToWX.Req();
                req4.message = msg4;
                req4.scene = SendMessageToWX.Req.WXSceneSession;  // 目前只支持会话
                api.sendReq(req4);

                break;

            case "link":
            default:

                //初始化一个WXWebpageObject，填写url
                WXWebpageObject webpage = new WXWebpageObject();
                webpage.webpageUrl = url;

                //用 WXWebpageObject 对象初始化一个 WXMediaMessage 对象
                WXMediaMessage msg3 = new WXMediaMessage(webpage);
                msg3.title = title;
                msg3.description = desc;

                msg3.thumbData = thumbBmp;

                //构造一个Req
                SendMessageToWX.Req req3 = new SendMessageToWX.Req();
//                req.transaction = buildTransaction("webpage");
                req3.message = msg3;
                req3.scene = mTargetScene;
                //调用api接口，发送数据到微信
                api.sendReq(req3);
                break;

        }


    }
}
