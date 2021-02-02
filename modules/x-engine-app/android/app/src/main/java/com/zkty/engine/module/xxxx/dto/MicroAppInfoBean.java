package com.zkty.engine.module.xxxx.dto;

import java.util.List;

public class MicroAppInfoBean {


    /**
     * appid
     */ /**
     * appid : 917d2f38aa104fe98bbc72dc976a6df8
     * appname : 国美APP
     * publicKey : null
     * method : null
     * microapps : [{"microAppId":"microAppId","appid":"917d2f38aa104fe98bbc72dc976a6df8","version":1,"name":"微应用","url":"/microapp-service/app/917d2f38aa104fe98bbc72dc976a6df8/microAppId/1","createTime":1611989838000,"md5":null,"path":null,"signature":"akZ26YKeByzIPY65g2wLXJdX34juEv0sNCBWw2f+C4zeW/Wxt1AEXJB5pPlrjUTUMfY9bm1bmf//fMsb8CZCaw=="},{"microAppId":"microAppId","appid":"917d2f38aa104fe98bbc72dc976a6df8","version":2,"name":"微应用","url":"/microapp-service/app/917d2f38aa104fe98bbc72dc976a6df8/microAppId/2","createTime":1611990298000,"md5":null,"path":null,"signature":"hfpjve4g9/xGVl8eRjShHNMniXnj5l+ZNLzV8jLLwOBU/uOU10mhoWyLpqvjnMApY76tM7vxJ2Fw9FeE5CibQg=="}]
     */

    private String appid;
    /**
     * appname
     */
    private String appname;
    /**
     * publicKey
     */
    private Object publicKey;
    /**
     * method
     */
    private Object method;
    /**
     * microapps
     */
    private List<MicroappsBean> microapps;

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getAppname() {
        return appname;
    }

    public void setAppname(String appname) {
        this.appname = appname;
    }

    public Object getPublicKey() {
        return publicKey;
    }

    public void setPublicKey(Object publicKey) {
        this.publicKey = publicKey;
    }

    public Object getMethod() {
        return method;
    }

    public void setMethod(Object method) {
        this.method = method;
    }

    public List<MicroappsBean> getMicroapps() {
        return microapps;
    }

    public void setMicroapps(List<MicroappsBean> microapps) {
        this.microapps = microapps;
    }

    public static class MicroappsBean {
        /**
         * microAppId
         */ /**
         * microAppId : microAppId
         * appid : 917d2f38aa104fe98bbc72dc976a6df8
         * version : 1
         * name : 微应用
         * url : /microapp-service/app/917d2f38aa104fe98bbc72dc976a6df8/microAppId/1
         * createTime : 1611989838000
         * md5 : null
         * path : null
         * signature : akZ26YKeByzIPY65g2wLXJdX34juEv0sNCBWw2f+C4zeW/Wxt1AEXJB5pPlrjUTUMfY9bm1bmf//fMsb8CZCaw==
         */

        private String microAppId;
        /**
         * appid
         */
        private String appid;
        /**
         * version
         */
        private int version;
        /**
         * name
         */
        private String name;
        /**
         * url
         */
        private String url;
        /**
         * createTime
         */
        private long createTime;
        /**
         * md5
         */
        private Object md5;
        /**
         * path
         */
        private Object path;
        /**
         * signature
         */
        private String signature;

        public String getMicroAppId() {
            return microAppId;
        }

        public void setMicroAppId(String microAppId) {
            this.microAppId = microAppId;
        }

        public String getAppid() {
            return appid;
        }

        public void setAppid(String appid) {
            this.appid = appid;
        }

        public int getVersion() {
            return version;
        }

        public void setVersion(int version) {
            this.version = version;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public long getCreateTime() {
            return createTime;
        }

        public void setCreateTime(long createTime) {
            this.createTime = createTime;
        }

        public Object getMd5() {
            return md5;
        }

        public void setMd5(Object md5) {
            this.md5 = md5;
        }

        public Object getPath() {
            return path;
        }

        public void setPath(Object path) {
            this.path = path;
        }

        public String getSignature() {
            return signature;
        }

        public void setSignature(String signature) {
            this.signature = signature;
        }
    }
}
