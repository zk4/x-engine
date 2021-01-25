package com.zkty.engine.module.xxxx.network.utils;

import java.io.BufferedWriter;
import java.io.Closeable;
import java.io.FileOutputStream;
import java.io.IOException;

public class StreamUtil {


    /**
     * 关闭流
     *
     * @param stream
     */
    public static void close(Closeable... streams) {
        for (Closeable stream : streams) {
            if (stream != null) {
                try {
                    stream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }

    /**
     * 关闭流
     *
     * @param stream
     */
    public static void flushAndClose(BufferedWriter stream) {

        if (stream != null) {
            try {
                stream.flush();
                stream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }

    }

    /**
     * 关闭流
     *
     * @param stream
     */
    public static void flushAndClose(FileOutputStream stream) {

        if (stream != null) {
            try {
                stream.flush();
                stream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }

        }

    }
}
