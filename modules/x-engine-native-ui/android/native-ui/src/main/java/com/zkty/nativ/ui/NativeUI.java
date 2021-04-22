package com.zkty.nativ.ui;

import com.zkty.nativ.core.NativeModule;

public class NativeUI extends NativeModule implements IUI {
    @Override
    public String moduleId() {
        return "com.zkty.native.ui";
    }

    @Override
    public void setNavBarHidden(boolean isHidden, boolean isAnimation) {
        
    }

    @Override
    public void setNavTitle(String title, String color, int textSize) {
        
    }
}
