package com.zkty.modules.engine.exception;

public class NoModuleIdException extends RuntimeException {

    public NoModuleIdException() {
        super();
    }

    public NoModuleIdException(String message) {
        super(message);
    }

    public NoModuleIdException(String message, Throwable cause) {
        super(message, cause);
    }

    public NoModuleIdException(Throwable cause) {
        super(cause);
    }

    protected NoModuleIdException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
        super(message, cause, enableSuppression, writableStackTrace);
    }
}
