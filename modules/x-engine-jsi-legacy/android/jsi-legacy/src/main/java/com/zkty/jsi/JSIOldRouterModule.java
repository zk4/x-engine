package com.zkty.jsi;

import android.text.TextUtils;
import android.webkit.JavascriptInterface;

import com.alibaba.fastjson.JSONObject;
import com.anthonynsimon.url.URL;
import com.anthonynsimon.url.exceptions.MalformedURLException;

import com.zkty.nativ.core.NativeContext;
import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.direct.IDirectManager;
import com.zkty.nativ.direct.NativeDirect;
import com.zkty.nativ.jsi.JSIModule;
import com.zkty.nativ.jsi.bridge.CompletionHandler;

import java.util.HashMap;
import java.util.Map;

public class JSIOldRouterModule extends JSIModule {

    private NativeDirect directors;

    @Override
    public String moduleId() {
        return "com.zkty.module.router";
    }

    @Override
    protected void afterAllJSIModuleInited() {

        NativeModule module = NativeContext.sharedInstance().getModuleByProtocol(IDirectManager.class);
        if (module instanceof NativeDirect)
            directors = (NativeDirect) module;
    }


    private JSONObject convertRouter2JSIModel(JSONObject obj) {
        JSONObject ret = new JSONObject();

        ret.put("scheme", obj.getString("type"));
        String host = obj.getString("uri");
        String url_need_check = null;
        if ("microapp".equals(obj.getString("type"))) {
            url_need_check = String.format("http://%s#%s", host, obj.getString("path"));
        } else {
            if (host.contains("#")) {
                url_need_check = String.format("%s%s", host, obj.getString("path"));
            } else {
                url_need_check = String.format("%s#%s", host, obj.getString("path"));

            }
        }
        String standard_url = SPAUrl2StandardUrl(url_need_check);
        try {
            URL url = URL.parse(standard_url);

            ret.put("host", url.getHost());

            if (!TextUtils.isEmpty(url.getPath())) {
                ret.put("pathname", url.getPath());
            }
            if (!TextUtils.isEmpty(url.getFragment())) {
                ret.put("fragment", url.getFragment());
            }

            if (url.getQueryPairs() != null) {
                ret.put("query", url.getQueryPairs());
            }
            if (obj.getBoolean("hideNavbar")) {
                Map<String, Boolean> map = new HashMap<>();
                map.put("hideNavbar", true);
                ret.put("params", map);
            }

        } catch (MalformedURLException e) {
            e.printStackTrace();
        }

        return ret;


    }

    //http://www.baidu.com/index.html#/test?id=1
    private String SPAUrl2StandardUrl(String raw) {
        int questionMark = -1;
        int hashtagMark = -1;

        for (int i = 0; i < raw.length(); i++) {
            char cc = raw.charAt(i);
            if (cc == '?' && hashtagMark == -1) {
                hashtagMark = i;
            }
            // 仅当找到 hashtag 后才再找?, 不然不是 SPA url
            if (hashtagMark != -1 && cc == '#' && questionMark == -1) {
                questionMark = i;
            }

        }
        if (questionMark != -1 && hashtagMark != -1) {
            String sub1 = raw.substring(0, hashtagMark);
            String sub2 = raw.substring(hashtagMark, questionMark);
            String sub3 = raw.substring(questionMark, raw.length() - 1);
            return String.format("%s%s%s", sub1, sub3, sub2);

        }
        return raw;

    }


    @JavascriptInterface
    public void openTargetRouter(JSONObject obj, final CompletionHandler<Object> handler) {
        JSONObject data = convertRouter2JSIModel(obj);

        if (data.get("host") == null) return;
        if (directors != null) {
            directors.push(data.getString("scheme"), data.getString("host"), data.getString("pathname"),
                    data.getString("fragment"),
                    data.get("query") == null ? null : (Map<String, Object>) data.get("query"),
                    data.get("params") == null ? null : (Map<String, Object>) data.get("params"));
        }
        handler.complete();

    }

}
