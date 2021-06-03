package com.zkty.engine.module.network.bean;

import android.text.TextUtils;

/**
 * @author : MaJi
 * @time : (4/22/21)
 * dexc :
 */
public class ImsessiionidBean2 {
    private Object extraMap;
    private String msg;
    private String status;
    private DataBean data;

    public Object getExtraMap() {
        return extraMap;
    }

    public String getMsg() {
        return msg;
    }

    public String getStatus() {
        return status;
    }

    public DataBean getData() {
        return data;
    }

    public class DataBean{
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

        public DataBean setImsession(String imsession) {
            this.imsession = imsession;
            return this;
        }

        public String getOrgi() {
            return orgi;
        }

        public DataBean setOrgi(String orgi) {
            this.orgi = orgi;
            return this;
        }

        public String getEntry() {
            return entry;
        }

        public DataBean setEntry(String entry) {
            this.entry = entry;
            return this;
        }

        public String getCompanyid() {
            return companyid;
        }

        public DataBean setCompanyid(String companyid) {
            this.companyid = companyid;
            return this;
        }

        public String getOrgitype() {
            return orgitype;
        }

        public DataBean setOrgitype(String orgitype) {
            this.orgitype = orgitype;
            return this;
        }

        public String getOrgilogo() {
            return orgilogo;
        }

        public DataBean setOrgilogo(String orgilogo) {
            this.orgilogo = orgilogo;
            return this;
        }

        public String getOrginame() {
            return orginame;
        }

        public DataBean setOrginame(String orginame) {
            this.orginame = orginame;
            return this;
        }

        public String getShowlabel() {
            return showlabel;
        }

        public DataBean setShowlabel(String showlabel) {
            this.showlabel = showlabel;
            return this;
        }

        public String getVip99() {
            return vip99;
        }

        public DataBean setVip99(String vip99) {
            this.vip99 = vip99;
            return this;
        }
    }

}
