package com.zkty.nativ.camera;

import java.util.Map;

public class CameraDTO {

    private boolean allowsEditing;
    private boolean savePhotosAlbum;
    private int cameraFlashMode;
    private String cameraDevice;
    private boolean isbase64;
    private Map<String, String> args;
    private int photoCount;

    public boolean isAllowsEditing() {
        return allowsEditing;
    }

    public void setAllowsEditing(boolean allowsEditing) {
        this.allowsEditing = allowsEditing;
    }

    public boolean isSavePhotosAlbum() {
        return savePhotosAlbum;
    }

    public void setSavePhotosAlbum(boolean savePhotosAlbum) {
        this.savePhotosAlbum = savePhotosAlbum;
    }

    public int getCameraFlashMode() {
        return cameraFlashMode;
    }

    public void setCameraFlashMode(int cameraFlashMode) {
        this.cameraFlashMode = cameraFlashMode;
    }

    public String getCameraDevice() {
        return cameraDevice;
    }

    public void setCameraDevice(String cameraDevice) {
        this.cameraDevice = cameraDevice;
    }

    public boolean isIsbase64() {
        return isbase64;
    }

    public void setIsbase64(boolean isbase64) {
        this.isbase64 = isbase64;
    }

    public Map<String, String> getArgs() {
        return args;
    }

    public void setArgs(Map<String, String> args) {
        this.args = args;
    }

    public int getPhotoCount() {
        return photoCount;
    }

    public void setPhotoCount(int photoCount) {
        this.photoCount = photoCount;
    }


    public boolean propertyIsOptional(String propertyName) {
        return "allowsEditing".equals(propertyName) ||
                "savePhotosAlbum".equals(propertyName) ||
                "cameraFlashMode".equals(propertyName) ||
                "cameraDevice".equals(propertyName) ||
                "photoCount".equals(propertyName);
    }

}
