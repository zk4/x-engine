package com.zkty.nativ.share_wx;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import com.tencent.mm.opensdk.modelmsg.SendMessageToWX;
import com.tencent.mm.opensdk.modelmsg.WXImageObject;
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage;
import com.tencent.mm.opensdk.modelmsg.WXMiniProgramObject;
import com.tencent.mm.opensdk.modelmsg.WXTextObject;
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.ImageUtils;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.share.Ishare;
import com.zkty.nativ.share.dto.ShareImg;
import com.zkty.nativ.share.dto.ShareLink;
import com.zkty.nativ.share.dto.ShareMiniProgram;
import com.zkty.nativ.share.dto.ShareText;

import java.util.ArrayList;
import java.util.List;

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
    public void share(String channel, ShareText info, CallBack callBack) {

        if (!isWxExited()) {
            callBack.onResult(-1);
            ToastUtils.showNormalShortToast("安装微信后分享");
            return;
        }
        IWXAPI iwxapi = createWXAPI();
        if (iwxapi == null) return;

        //初始化一个 WXTextObject 对象，填写分享的文本内容
        WXTextObject textObj = new WXTextObject();
        textObj.text = info.text;

        //用 WXTextObject 对象初始化一个 WXMediaMessage 对象
        WXMediaMessage msg = new WXMediaMessage();
        msg.mediaObject = textObj;
        msg.description = info.text;

        SendMessageToWX.Req req = new SendMessageToWX.Req();
        req.message = msg;
        req.scene = "wx_friend".equals(channel) ? SendMessageToWX.Req.WXSceneSession : SendMessageToWX.Req.WXSceneTimeline;
        //调用api接口，发送数据到微信
        iwxapi.sendReq(req);
        callBack.onResult(0);

    }

    @Override
    public void share(String channel, ShareImg info, CallBack callBack) {
        if (!isWxExited()) {
            callBack.onResult(-1);
            ToastUtils.showNormalShortToast("安装微信后分享");
            return;
        }
        if (TextUtils.isEmpty(info.imgData)) {
            callBack.onResult(-1);
            ToastUtils.showNormalShortToast("图片不能为空");
            return;
        }

        IWXAPI iwxapi = createWXAPI();
        if (iwxapi == null) return;
        Handler handler = new Handler(Looper.getMainLooper());
        ImageUtils.getBitmap(info.imgData, new ImageUtils.BitmapCallback() {
            @Override
            public void onSuccess(Bitmap bitmap) {

                handler.post(() -> {
                    //初始化 WXImageObject 和 WXMediaMessage 对象
                    WXImageObject imgObj = new WXImageObject(bitmap);
                    WXMediaMessage msg2 = new WXMediaMessage();
                    msg2.mediaObject = imgObj;

                    //设置缩略图
                    Bitmap thumbBmp = Bitmap.createScaledBitmap(bitmap, 50, 50, true);
                    msg2.thumbData = ImageUtils.bitmapToBytes(thumbBmp);

                    //构造一个Req
                    SendMessageToWX.Req req2 = new SendMessageToWX.Req();
                    req2.message = msg2;
                    req2.scene = "wx_friend".equals(channel) ? SendMessageToWX.Req.WXSceneSession : SendMessageToWX.Req.WXSceneTimeline;
                    //调用api接口，发送数据到微信
                    iwxapi.sendReq(req2);
//                    if (!bitmap.isRecycled() && !bitmap.equals(thumbBmp))
//                        bitmap.recycle();
//                    if (!thumbBmp.isRecycled() && !thumbBmp.equals(bitmap))
//                        thumbBmp.recycle();
                });

            }

            @Override
            public void onFail() {
                handler.post(() -> {
                    ToastUtils.showNormalShortToast("图片解析失败，请重试");
                });
            }
        });

        callBack.onResult(0);
    }

    @Override
    public void share(String channel, ShareLink info, CallBack callBack) {
        if (!isWxExited()) {
            callBack.onResult(-1);
            ToastUtils.showNormalShortToast("安装微信后分享");
            return;
        }

        IWXAPI iwxapi = createWXAPI();
        if (iwxapi == null) return;
        Handler handler = new Handler(Looper.getMainLooper());
        ImageUtils.getBitmap(info.imgUrl, new ImageUtils.BitmapCallback() {
            @Override
            public void onSuccess(Bitmap bitmap) {

                handler.post(() -> {
                    //初始化一个WXWebpageObject，填写url
                    WXWebpageObject webpage = new WXWebpageObject();
                    webpage.webpageUrl = info.url;

                    //用 WXWebpageObject 对象初始化一个 WXMediaMessage 对象
                    WXMediaMessage msg3 = new WXMediaMessage(webpage);
                    msg3.title = info.title;
                    msg3.description = info.desc;
                    if (bitmap != null) {
                        Bitmap thumbBmp = Bitmap.createScaledBitmap(bitmap, 50, 50, true);
                        msg3.thumbData = ImageUtils.bitmapToBytes(thumbBmp);
                    }


                    //构造一个Req
                    SendMessageToWX.Req req3 = new SendMessageToWX.Req();
//                req.transaction = buildTransaction("webpage");
                    req3.message = msg3;
                    req3.scene = "wx_friend".equals(channel) ? SendMessageToWX.Req.WXSceneSession : SendMessageToWX.Req.WXSceneTimeline;
                    //调用api接口，发送数据到微信
                    iwxapi.sendReq(req3);

                });


            }

            @Override
            public void onFail() {

                handler.post(() -> {
                    //初始化一个WXWebpageObject，填写url
                    WXWebpageObject webpage = new WXWebpageObject();
                    webpage.webpageUrl = info.url;

                    //用 WXWebpageObject 对象初始化一个 WXMediaMessage 对象
                    WXMediaMessage msg3 = new WXMediaMessage(webpage);
                    msg3.title = info.title;
                    msg3.description = info.desc;

                    //构造一个Req
                    SendMessageToWX.Req req3 = new SendMessageToWX.Req();
//                req.transaction = buildTransaction("webpage");
                    req3.message = msg3;
                    req3.scene = "wx_friend".equals(channel) ? SendMessageToWX.Req.WXSceneSession : SendMessageToWX.Req.WXSceneTimeline;
                    //调用api接口，发送数据到微信
                    iwxapi.sendReq(req3);
                });

            }
        });

        callBack.onResult(0);
    }

    @Override
    public void share(ShareMiniProgram info, CallBack callBack) {
        if (!isWxExited()) {
            callBack.onResult(-1);
            ToastUtils.showNormalShortToast("安装微信后分享");
            return;
        }

        IWXAPI iwxapi = createWXAPI();
        if (iwxapi == null) return;
        Handler handler = new Handler(Looper.getMainLooper());
        ImageUtils.getBitmap(info.imgUrl, new ImageUtils.BitmapCallback() {
            @Override
            public void onSuccess(Bitmap bitmap) {
                handler.post(() -> {

                    WXMiniProgramObject miniProgramObj = new WXMiniProgramObject();
                    miniProgramObj.webpageUrl = info.link; // 兼容低版本的网页链接
                    miniProgramObj.miniprogramType = info.miniProgramType == 0 ?
                            WXMiniProgramObject.MINIPTOGRAM_TYPE_RELEASE : info.miniProgramType == 1 ?
                            WXMiniProgramObject.MINIPROGRAM_TYPE_TEST : WXMiniProgramObject.MINIPROGRAM_TYPE_PREVIEW;// 正式版:0，测试版:1，体验版:2
                    miniProgramObj.userName = info.userName;     // 小程序原始id
                    miniProgramObj.path = info.path;            //小程序页面路径；对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"
                    WXMediaMessage msg4 = new WXMediaMessage(miniProgramObj);
                    msg4.title = info.title;                    // 小程序消息title
                    msg4.description = info.desc;               // 小程序消息desc

                    if (bitmap != null) {
                        Bitmap thumbBmp = Bitmap.createScaledBitmap(bitmap, 250, 250, true);
                        msg4.thumbData = ImageUtils.bitmapToBytes(thumbBmp);                      // 小程序消息封面图片，小于128k
                    }
                    SendMessageToWX.Req req4 = new SendMessageToWX.Req();
                    req4.message = msg4;
                    req4.scene = SendMessageToWX.Req.WXSceneSession;  // 目前只支持会话
                    iwxapi.sendReq(req4);

                });


            }

            @Override
            public void onFail() {
                handler.post(() -> {
                    WXMiniProgramObject miniProgramObj = new WXMiniProgramObject();
                    miniProgramObj.webpageUrl = info.link; // 兼容低版本的网页链接
                    miniProgramObj.miniprogramType = info.miniProgramType == 0 ?
                            WXMiniProgramObject.MINIPTOGRAM_TYPE_RELEASE : info.miniProgramType == 1 ?
                            WXMiniProgramObject.MINIPROGRAM_TYPE_TEST : WXMiniProgramObject.MINIPROGRAM_TYPE_PREVIEW;// 正式版:0，测试版:1，体验版:2
                    miniProgramObj.userName = info.userName;     // 小程序原始id
                    miniProgramObj.path = info.path;            //小程序页面路径；对于小游戏，可以只传入 query 部分，来实现传参效果，如：传入 "?foo=bar"
                    WXMediaMessage msg4 = new WXMediaMessage(miniProgramObj);
                    msg4.title = info.title;                    // 小程序消息title
                    msg4.description = info.desc;               // 小程序消息desc

                    SendMessageToWX.Req req4 = new SendMessageToWX.Req();
                    req4.message = msg4;
                    req4.scene = SendMessageToWX.Req.WXSceneSession;  // 目前只支持会话
                    iwxapi.sendReq(req4);
                });

            }
        });
        callBack.onResult(0);
    }

    private IWXAPI createWXAPI() {
        String appId = null;
        Context context = XEngineApplication.getCurrentActivity();
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
        if (TextUtils.isEmpty(appId)) return null;

        return WXAPIFactory.createWXAPI(context, appId);


    }

    private boolean isWxExited() {

        boolean bHas = true;
        try {
            XEngineApplication.getApplication().getPackageManager().getPackageInfo("com.tencent.mm", PackageManager.GET_GIDS);
        } catch (PackageManager.NameNotFoundException e) {
            // 抛出找不到的异常，说明该程序已经被卸载
            bHas = false;
        }

        return bHas;
    }

}
