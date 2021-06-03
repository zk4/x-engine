package com.zkty.nativ.viewer.utils;

import java.util.LinkedHashMap;

/**
 * @author : MaJi
 * @time : (5/31/21)
 * dexc :HTTP Content-type 对照表
 */
public class ResponseContentTypeUtils {


    /**
     * Content-Type(Mime-Type)
     * 文件扩展名
     */
    public static LinkedHashMap<String, String> FILE_TYPE_MAP;


    static {
        FILE_TYPE_MAP = new LinkedHashMap<>();
        FILE_TYPE_MAP.put("application/pdf",".pdf");
        FILE_TYPE_MAP.put("application/msword",".doc");
        FILE_TYPE_MAP.put("application/vnd.openxmlformats-officedocument.wordprocessingml.document",".docx");
        FILE_TYPE_MAP.put("application/vnd.ms-excel",".xls");
        FILE_TYPE_MAP.put("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",".xlsx");
        FILE_TYPE_MAP.put("application/vnd.ms-powerpoint",".ppt");
        FILE_TYPE_MAP.put("application/vnd.openxmlformats-officedocument.presentationml.presentation",".pptx");
    }

}