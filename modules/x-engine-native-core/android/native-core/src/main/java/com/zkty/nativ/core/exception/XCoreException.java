package com.zkty.nativ.core.exception;

public class XCoreException extends RuntimeException {

    public XCoreException() {
        super();
    }

    public XCoreException(String message) {
        super(message);
    }

    public XCoreException(String message, Throwable cause) {
        super(message, cause);
    }

    public XCoreException(Throwable cause) {
        super(cause);
    }

    protected XCoreException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
