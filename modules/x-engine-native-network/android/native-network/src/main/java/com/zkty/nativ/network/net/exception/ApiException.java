package com.zkty.nativ.network.net.exception;

public class ApiException extends Exception {
    public int code;
    public ErrorInfo errorInfo;

    public ApiException() {
        super();
        this.code = -1;
        errorInfo = new ErrorInfo();
    }

    public ApiException(int code) {
        super();
        this.code = code;
        errorInfo = new ErrorInfo();
    }

    public ApiException(Throwable throwable, int code) {
        super(throwable);
        this.code = code;
        errorInfo = new ErrorInfo();
    }

    public static class ErrorInfo {
        public int code;
        public String message;
        public String type;
        public String error;
        public String error_message;
        public String error_description;
    }
}
