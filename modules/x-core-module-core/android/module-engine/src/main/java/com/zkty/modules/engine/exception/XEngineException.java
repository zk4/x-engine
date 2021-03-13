package com.zkty.modules.engine.exception;

public class XEngineException extends RuntimeException {

    public XEngineException() {
        super();
    }

    public XEngineException(String message) {
        super(message);
    }

    public XEngineException(String message, Throwable cause) {
        super(message, cause);
    }

    public XEngineException(Throwable cause) {
        super(cause);
    }

    protected XEngineException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
