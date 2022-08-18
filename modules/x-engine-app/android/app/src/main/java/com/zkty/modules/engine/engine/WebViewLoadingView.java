package com.zkty.modules.engine.engine;

import android.content.Context;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.github.penfeizhou.animation.apng.APNGDrawable;
import com.github.penfeizhou.animation.loader.ResourceStreamLoader;
import com.zkty.modules.engine.R;

public class WebViewLoadingView extends RelativeLayout {
    public WebViewLoadingView(Context context) {
        super(context);
        init(context);
    }

    public WebViewLoadingView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public WebViewLoadingView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init(context);
    }

    private void init(Context context) {
        View view = View.inflate(context, R.layout.layout_web_loading, this);
        ImageView iv = view.findViewById(R.id.iv_image);
        ResourceStreamLoader loader = new ResourceStreamLoader(context, R.mipmap.ic_apng);
        APNGDrawable drawable = new APNGDrawable(loader);
        iv.setImageDrawable(drawable);
        drawable.setLoopLimit(Integer.MAX_VALUE);

    }

}
