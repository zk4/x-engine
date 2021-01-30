package pay;

public class PayBean {
    private String orderFlowNo;     //订单号
    private String businessCstNo;   //客户号
    private String platMerCstNo;    //商户号
    private String frontBackUrl;    //前端回调地址


    public String getOrderFlowNo() {
        return orderFlowNo;
    }

    public void setOrderFlowNo(String orderFlowNo) {
        this.orderFlowNo = orderFlowNo;
    }

    public String getBusinessCstNo() {
        return businessCstNo;
    }

    public void setBusinessCstNo(String businessCstNo) {
        this.businessCstNo = businessCstNo;
    }

    public String getPlatMerCstNo() {
        return platMerCstNo;
    }

    public void setPlatMerCstNo(String platMerCstNo) {
        this.platMerCstNo = platMerCstNo;
    }

    public String getFrontBackUrl() {
        return frontBackUrl;
    }

    public void setFrontBackUrl(String frontBackUrl) {
        this.frontBackUrl = frontBackUrl;
    }
}
