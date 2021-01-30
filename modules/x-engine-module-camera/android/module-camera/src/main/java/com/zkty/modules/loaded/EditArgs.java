package com.zkty.modules.loaded;

import java.io.Serializable;

public class EditArgs implements Serializable {
    private String width;
    private String height;
    private String quality;
    private String bytes;

    private int photoCount;

    public String getWidth() {
        return width;
    }

    public void setWidth(String width) {
        this.width = width;
    }

    public String getHeight() {
        return height;
    }

    public void setHeight(String height) {
        this.height = height;
    }

    public String getQuality() {
        return quality;
    }

    public void setQuality(String quality) {
        this.quality = quality;
    }

    public String getBytes() {
        return bytes;
    }

    public void setBytes(String bytes) {
        this.bytes = bytes;
    }

    public int getPhotoCount() {
        return photoCount;
    }

    public void setPhotoCount(int photoCount) {
        this.photoCount = photoCount;
    }

    @Override
    public String toString() {
        return "EditArgs{" +
                "width='" + width + '\'' +
                ", height='" + height + '\'' +
                ", quality='" + quality + '\'' +
                ", bytes='" + bytes + '\'' +
                '}';
    }
}
