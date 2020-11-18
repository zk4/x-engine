package com.zkty.modules.loaded.jsapi;

import android.content.Context;

import com.alibaba.fastjson.JSON;
import com.zkty.modules.engine.XEngineApplication;
import com.zkty.modules.engine.utils.ActivityUtils;
import com.zkty.modules.engine.utils.XEngineWebActivityManager;

import java.lang.reflect.Constructor;
import java.lang.reflect.Method;

public class RouterAspect {

    private final static String APPB_ROUTER_CLASS = "cn.timesneighborhood.app.b.router.RouterWrapper";
    private final static String APPC_ROUTER_CLASS = "cn.timesneighborhood.app.c.router.RouterManager";

    public static void openTargetRouter(String type, String uri, String path, String arg, String version) {

        try {
            Class routerWrapper = Class.forName(APPB_ROUTER_CLASS);
            Constructor<?> constructor = routerWrapper.getDeclaredConstructor();
            constructor.setAccessible(true);
            Object object = constructor.newInstance();
            Method methodModule = routerWrapper.getMethod("openTargetRouter", Context.class, String.class, String.class, String.class, String.class, String.class, long.class);
            methodModule.invoke(object, ActivityUtils.getCurrentActivity(), type, uri, path, arg, version, 0);
            return;

        } catch (Exception e) {

        }


        try {
            Class routerWrapper = Class.forName(APPC_ROUTER_CLASS);
            Constructor<?> constructor = routerWrapper.getDeclaredConstructor();
            constructor.setAccessible(true);
            Object object = constructor.newInstance();
            //Context context, String checkUrl, String type, String uri, String path, String arg, String version, String msgTips
            Method methodModule = routerWrapper.getMethod("openTargetRouter", Context.class, String.class, String.class, String.class, String.class, String.class, String.class, String.class);
            methodModule.invoke(object, ActivityUtils.getCurrentActivity(), null, type, uri, path, arg, version, null);
            return;

        } catch (Exception e) {

        }


        RouterMaster.openTargetRouter(XEngineWebActivityManager.sharedInstance().getCurrent(), type, uri, path, arg, version);

    }

}
