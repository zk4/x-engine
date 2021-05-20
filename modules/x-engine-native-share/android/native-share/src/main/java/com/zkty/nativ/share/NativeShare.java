package com.zkty.nativ.share;

import android.graphics.Bitmap;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.utils.ImageUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NativeShare extends NativeModule implements IShareManager {
    {
        shares = new HashMap<>();
    }

    private Map<String, Ishare> shares;


    @Override
    public String moduleId() {
        return "com.zkty.native.share";
    }

    @Override
    public void afterAllNativeModuleInited() {
        List<NativeModule> modules = NativeContext.sharedInstance().getModulesByProtocol(Ishare.class);
        for (NativeModule ishare : modules) {
            if (ishare instanceof Ishare) {
                for (String channel : ((Ishare) ishare).channels())
                    shares.put(channel, (Ishare) ishare);
            }
        }

    }

    @Override
    public void share(String channel, String type, String text, String title, String desc, String imgUrl, String imgData, Bitmap imgBitmap, String url, String userName, String path, String link, int miniProgramType) {
        Ishare ishare = shares.get(channel);
        if (ishare != null) {
            ishare.share(channel, type, text, title, desc, imgUrl, imgData, imgBitmap, url, userName, path, link, miniProgramType);
        }
    }
}
