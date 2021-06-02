package com.zkty.engine.module.network;

import android.text.TextUtils;

/**
 * @author : MaJi
 * @time : (4/22/21)
 * dexc :
 */
public class ImsessiionidBean {
    private String imsession;
    private String orgi;
    private String skill;
    private String entry;
    private String companyid;
    private String orgitype;
    private String orgilogo;
    private String orginame;
    private String showlabel;
    private String vip99;


    public String getSkill() {
        return TextUtils.isEmpty(skill) ? "" : skill;
    }

    public void setSkill(String skill) {
        this.skill = skill;
    }

    public String getImsession() {
        return imsession;
    }

    public void setImsession(String imsession) {
        this.imsession = imsession;
    }

    public String getOrgi() {
        return orgi;
    }

    public void setOrgi(String orgi) {
        this.orgi = orgi;
    }

    public String getEntry() {
        return entry;
    }

    public void setEntry(String entry) {
        this.entry = entry;
    }

    public String getCompanyid() {
        return companyid;
    }

    public void setCompanyid(String companyid) {
        this.companyid = companyid;
    }

    public String getOrgitype() {
        return orgitype;
    }

    public void setOrgitype(String orgitype) {
        this.orgitype = orgitype;
    }

    public String getOrgilogo() {
        return orgilogo;
    }

    public void setOrgilogo(String orgilogo) {
        this.orgilogo = orgilogo;
    }

    public String getOrginame() {
        return orginame;
    }

    public void setOrginame(String orginame) {
        this.orginame = orginame;
    }

    public String getShowlabel() {
        return showlabel;
    }

    public void setShowlabel(String showlabel) {
        this.showlabel = showlabel;
    }

    public String getVip99() {
        return vip99;
    }

    public void setVip99(String vip99) {
        this.vip99 = vip99;
    }

}
