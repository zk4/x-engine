package com.zkty.nativ.camera;

import com.zkty.nativ.core.NativeModule;

public class NativeCamera extends NativeModule implements ICamera {
    @Override
    public String moduleId() {
        return "com.zkty.native.camera";
    }

    @Override
    public void openImagePicker(CameraDTO dto, CallBack callBack) {

    }


}
