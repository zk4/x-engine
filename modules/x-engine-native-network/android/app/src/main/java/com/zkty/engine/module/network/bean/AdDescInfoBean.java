package com.zkty.engine.module.network.bean;

import java.io.Serializable;
import java.util.List;

/**
 * @author : MaJi
 * @time : (3/20/21)
 * dexc : 广告位
 */
public class AdDescInfoBean implements Serializable {


    private List<AdDescVOSBean> adDescVOS;

    public List<AdDescVOSBean> getAdDescVOS() {
        return adDescVOS;
    }

    public void setAdDescVOS(List<AdDescVOSBean> adDescVOS) {
        this.adDescVOS = adDescVOS;
    }

    public static class AdDescVOSBean implements Serializable{
        /**
         * adDescId : 226
         * adPlaceId : 127
         * adPlaceName : 首页弹窗广告
         * putBody : 小米官方售卖
         * orderSort : 100
         * lineType : 0
         * auditType : 0
         * createdTime : 2021-03-19 20:15:51
         * updatedTime : 2021-03-20 06:39:08
         * exposureData : 0
         * routerName : 链接
         * routerIcon : http://bjgc11.gos.gomedc.com/gm-nxcloud/general/2021-03-19/dd1188574c3f3d39b723e5e7d7bd46b5.jpg
         * routerUri : https://www.baidu.com/
         * adDescType : 1
         * textSum : 20
         */

        private Integer adDescId;
        private Integer adPlaceId;
        private String adPlaceName;
        private String putBody;
        private Integer orderSort;
        private String lineType;
        private Integer auditType;
        private String createdTime;
        private String updatedTime;
        private Integer exposureData;
        private String routerName;
        private String routerIcon;
        private String routerUri;
        private Integer adDescType;
        private Integer textSum;

        public Integer getAdDescId() {
            return adDescId;
        }

        public void setAdDescId(Integer adDescId) {
            this.adDescId = adDescId;
        }

        public Integer getAdPlaceId() {
            return adPlaceId;
        }

        public void setAdPlaceId(Integer adPlaceId) {
            this.adPlaceId = adPlaceId;
        }

        public String getAdPlaceName() {
            return adPlaceName;
        }

        public void setAdPlaceName(String adPlaceName) {
            this.adPlaceName = adPlaceName;
        }

        public String getPutBody() {
            return putBody;
        }

        public void setPutBody(String putBody) {
            this.putBody = putBody;
        }

        public Integer getOrderSort() {
            return orderSort;
        }

        public void setOrderSort(Integer orderSort) {
            this.orderSort = orderSort;
        }

        public String getLineType() {
            return lineType;
        }

        public void setLineType(String lineType) {
            this.lineType = lineType;
        }

        public Integer getAuditType() {
            return auditType;
        }

        public void setAuditType(Integer auditType) {
            this.auditType = auditType;
        }

        public String getCreatedTime() {
            return createdTime;
        }

        public void setCreatedTime(String createdTime) {
            this.createdTime = createdTime;
        }

        public String getUpdatedTime() {
            return updatedTime;
        }

        public void setUpdatedTime(String updatedTime) {
            this.updatedTime = updatedTime;
        }

        public Integer getExposureData() {
            return exposureData;
        }

        public void setExposureData(Integer exposureData) {
            this.exposureData = exposureData;
        }

        public String getRouterName() {
            return routerName;
        }

        public void setRouterName(String routerName) {
            this.routerName = routerName;
        }

        public String getRouterIcon() {
            return routerIcon;
        }

        public void setRouterIcon(String routerIcon) {
            this.routerIcon = routerIcon;
        }

        public String getRouterUri() {
            return routerUri;
        }

        public void setRouterUri(String routerUri) {
            this.routerUri = routerUri;
        }

        public Integer getAdDescType() {
            return adDescType;
        }

        public void setAdDescType(Integer adDescType) {
            this.adDescType = adDescType;
        }

        public Integer getTextSum() {
            return textSum;
        }

        public void setTextSum(Integer textSum) {
            this.textSum = textSum;
        }
    }
}
