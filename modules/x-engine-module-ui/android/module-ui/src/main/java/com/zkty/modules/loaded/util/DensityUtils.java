package com.zkty.modules.loaded.util;

import android.content.Context;


public class DensityUtils {
    private DensityUtils() {
    }

    /**
     * dip to Pixels
     *
     * @param context
     * @param dip
     * @return
     */
    public static int dipToPixels(Context context, float dip) {
        final float SCALE = context.getResources().getDisplayMetrics().density;
        float valueDips = dip;
        return (int) (valueDips * SCALE + 0.5f);

    }


    /**
     * px to dp
     *
     * @param context
     * @param Pixels
     * @return
     */
    public static float pixelsToDip(Context context, float pixels) {
        final float SCALE = context.getResources().getDisplayMetrics().density;
        return pixels / SCALE;
    }

    public static int getScreenWidth(Context context) {
        return context.getResources().getDisplayMetrics().widthPixels;
    }

    public static int getScreenHeight(Context context) {
        return context.getResources().getDisplayMetrics().heightPixels;
    }

}
