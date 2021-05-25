package com.zkty.nativ.network.bean;


public class CommonNodeResponseBaseBean<T> {

    /**
     * jsonrpc : 2.0
     * result : -19
     * id : 2
     */

    private String jsonrpc;
    private T result;
    private int id;
    /**
     * error : {"code":-32601,"message":"Method not found"}
     * id : 1
     */

    private ErrorBean error;

    public String getJsonrpc() {
        return jsonrpc;
    }

    public void setJsonrpc(String jsonrpc) {
        this.jsonrpc = jsonrpc;
    }

    public T getResult() {
        return result;
    }

    public void setResult(T result) {
        this.result = result;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public ErrorBean getError() {
        return error;
    }

    public void setError(ErrorBean error) {
        this.error = error;
    }


    public static class ErrorBean {
        /**
         * code : -32601
         * message : Method not found
         */

        private int code;
        private String message;

        public int getCode() {
            return code;
        }

        public void setCode(int code) {
            this.code = code;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}
