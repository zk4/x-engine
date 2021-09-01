package com.zkty.nativ.media;

public class CameraRetDTO {
    private String thumbnail;
    private String id;
    private String type;
    private String retImage;
    private String fileName;
    private String contentType;
    private String width;
    private String height;

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean propertyIsOptional(String propertyName) {
        return false;
    }

    public String getRetImage() {
        return retImage;
    }

    public CameraRetDTO setRetImage(String retImage) {
        this.retImage = retImage;
        return this;
    }

    public String getFileName() {
        return fileName;
    }

    public CameraRetDTO setFileName(String fileName) {
        this.fileName = fileName;
        return this;
    }

    public String getContentType() {
        return contentType;
    }

    public CameraRetDTO setContentType(String contentType) {
        this.contentType = contentType;
        return this;
    }

    public String getWidth() {
        return width;
    }

    public CameraRetDTO setWidth(String width) {
        this.width = width;
        return this;
    }

    public String getHeight() {
        return height;
    }

    public CameraRetDTO setHeight(String height) {
        this.height = height;
        return this;
    }
}
