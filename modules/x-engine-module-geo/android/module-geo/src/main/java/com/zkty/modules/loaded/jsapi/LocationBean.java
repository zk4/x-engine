package com.zkty.modules.loaded.jsapi;

import java.io.Serializable;

public class LocationBean implements Serializable {

    private String province;
    private String city;
    private String detailAdress;
    private double lat;
    private double lng;

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getDetailAdress() {
        return detailAdress;
    }

    public void setDetailAdress(String detailAdress) {
        this.detailAdress = detailAdress;
    }

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }

    public double getLng() {
        return lng;
    }

    public void setLng(double lng) {
        this.lng = lng;
    }
}
