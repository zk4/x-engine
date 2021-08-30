package com.zkty.nativ.ui;

import android.app.Activity;

import com.zkty.nativ.core.NativeModule;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.view.XEngineWebActivity;

public class NativeUI extends NativeModule implements IUI {
    @Override
    public String moduleId() {
        return "com.zkty.native.ui";
    }

    @Override
    public void setNavBarHidden(boolean isHidden, boolean isAnimation) {

        Activity activity = XEngineApplication.getCurrentActivity();
        if (activity instanceof XEngineWebActivity) {
            activity.runOnUiThread(() -> ((XEngineWebActivity) activity).setNavBarHidden(isHidden, isAnimation));

        }

    }

    @Override
    public void setNavTitle(String title, String color, int textSize) {
        Activity activity = XEngineApplication.getCurrentActivity();
        if (activity instanceof XEngineWebActivity) {
            activity.runOnUiThread(() -> ((XEngineWebActivity) activity).setNavTitle(title, color, textSize));
           
        }
    }
}
