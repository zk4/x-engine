package com.zkty.modules.loaded.jsapi;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.text.TextUtils;

import com.bumptech.glide.util.Util;
import com.tencent.mm.opensdk.modelmsg.SendMessageToWX;
import com.tencent.mm.opensdk.modelmsg.WXMediaMessage;
import com.tencent.mm.opensdk.modelmsg.WXWebpageObject;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;


public class ShareMaster {


    public static void share(Context context, String type, String title, String desc, String link, String imgUrl) {


        switch (type) {

            case "wx":
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

                //初始化一个WXWebpageObject，填写url
                WXWebpageObject webpage = new WXWebpageObject();
                webpage.webpageUrl = link;

                //用 WXWebpageObject 对象初始化一个 WXMediaMessage 对象
                WXMediaMessage msg = new WXMediaMessage(webpage);
                msg.title = title;
                msg.description = desc;
//                Bitmap thumbBmp = BitmapFactory.decodeResource(getResources(), R.drawable.send_music_thumb);
                //msg.thumbData = imgUrl;

                //构造一个Req
                SendMessageToWX.Req req = new SendMessageToWX.Req();
//                req.transaction = buildTransaction("webpage");
                req.message = msg;
//                req.scene = mTargetScene;
//                req.userOpenId = getOpenId();

                //调用api接口，发送数据到微信
                api.sendReq(req);


                break;


        }


    }
}
