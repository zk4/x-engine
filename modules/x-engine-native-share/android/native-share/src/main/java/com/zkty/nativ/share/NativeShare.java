package com.zkty.nativ.share;

import androidx.appcompat.app.AlertDialog;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.exception.XCoreException;
import com.zkty.nativ.share.dto.ShareImg;
import com.zkty.nativ.share.dto.ShareLink;
import com.zkty.nativ.share.dto.ShareMiniProgram;
import com.zkty.nativ.share.dto.ShareText;

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
    public void share(String channel, String type, Map<String, String> info) {
        Ishare ishare = shares.get(channel);
        if (ishare != null) {
            try {
                switch (type) {
                    case "text":
                        ShareText text = convert(info, ShareText.class);
                        ishare.share(channel, text);
                        break;
                    case "img":
                        ShareImg img = convert(info, ShareImg.class);
                        ishare.share(channel, img);
                        break;
                    case "link":
                        ShareLink link = convert(info, ShareLink.class);
                        ishare.share(channel, link);
                        break;
                    case "miniProgram":
                        ShareMiniProgram miniProgram = convert(info, ShareMiniProgram.class);
                        ishare.share(miniProgram);
                        break;
                    default:
                        break;

                }
            } catch (XCoreException e) {

                AlertDialog dialog = new AlertDialog.Builder(XEngineApplication.getCurrentActivity())
                        .setTitle("notice")
                        .setMessage(e.getMessage())
                        .setCancelable(true).create();
                dialog.show();

            }

        }
    }
}
