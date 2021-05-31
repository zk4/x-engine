package com.zkty.nativ.viewer.utils;

import java.util.LinkedHashMap;

/**
 * @author : MaJi
 * @time : (5/31/21)
 * dexc :HTTP Content-type 对照表
 */
public class ResponseContentTypeUtils {

    /**
     * 文件扩展名
     * Content-Type(Mime-Type)
     */
    public static LinkedHashMap<String, String> CONTENT_TYPE_MAP;

    /**
     * Content-Type(Mime-Type)
     * 文件扩展名
     */
    public static LinkedHashMap<String, String> FILE_TYPE_MAP;

    static {
        CONTENT_TYPE_MAP = new LinkedHashMap<>();
        CONTENT_TYPE_MAP.put(".","application/x-");
        CONTENT_TYPE_MAP.put(".*","application/octet-stream");
        CONTENT_TYPE_MAP.put(".zip","application/zip");

        CONTENT_TYPE_MAP.put(".pdf","application/pdf");
        CONTENT_TYPE_MAP.put(".xls","application/x-xls");
        CONTENT_TYPE_MAP.put(".xls","application/vnd.ms-excel");
        CONTENT_TYPE_MAP.put(".doc","application/msword");
        CONTENT_TYPE_MAP.put(".ppt","application/x-ppt");
        CONTENT_TYPE_MAP.put(".ppt","application/vnd.ms-powerpoint");
    }

    static {
        FILE_TYPE_MAP = new LinkedHashMap<>();
        FILE_TYPE_MAP.put("application/x-",".");
        FILE_TYPE_MAP.put("application/octet-stream",".*");
        FILE_TYPE_MAP.put("application/zip",".zip");
        FILE_TYPE_MAP.put("application/pdf",".pdf");
        FILE_TYPE_MAP.put("application/x-xls",".xls");
        FILE_TYPE_MAP.put("application/vnd.ms-excel",".xls");
        FILE_TYPE_MAP.put("application/x-xls",".xlsx");
        FILE_TYPE_MAP.put("application/vnd.ms-excel",".xlsx");
        FILE_TYPE_MAP.put("application/msword",".doc");
        FILE_TYPE_MAP.put("application/msword",".docx");
        FILE_TYPE_MAP.put("application/x-ppt",".ppt");
        FILE_TYPE_MAP.put("application/vnd.ms-powerpoint",".ppt");
        FILE_TYPE_MAP.put("application/x-ppt",".pptx");
        FILE_TYPE_MAP.put("application/vnd.ms-powerpoint",".pptx");
    }

}