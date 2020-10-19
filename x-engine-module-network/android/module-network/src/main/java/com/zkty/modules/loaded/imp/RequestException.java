package com.zkty.modules.loaded.imp;

public class RequestException extends Exception {
    public RequestException(String message) {
        super(message);
    }


    public static void throwParamsException(String message) {
        try {
            throw new RequestException(message);
        } catch (RequestException e) {
            e.printStackTrace();
        }
    }
}
