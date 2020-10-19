package com.zkty.modules.loaded.widget.dialog;

import android.content.Context;
import android.graphics.Matrix;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.Interpolator;
import android.view.animation.LinearInterpolator;
import android.view.animation.RotateAnimation;
import android.widget.ImageView;
import android.widget.LinearLayout;

import module.ui.R;


public class LoadingView extends LinearLayout {
    static final int DEFAULT_ROTATION_ANIMATION_DURATION = 150;
    static final int ROTATION_ANIMATION_DURATION = 1200;
    private ImageView ivWrapper;
    private Context mContext;
    private ImageView ivInner;

    public LoadingView(Context context) {
        super(context);
        mContext = context;
        init(context);
    }

    public LoadingView(Context context, AttributeSet attrs) {
        super(context, attrs);
        mContext = context;
        init(context);
    }

    private void init(Context context) {
        View view = View.inflate(context, R.layout.loading_layout, null);
        ivInner = (ImageView) view.findViewById(R.id.iv_inner);
        ivWrapper = (ImageView) view.findViewById(R.id.iv_wrapper);
        removeAllViews();
        addView(view);
        initWrapper();
        initInterior();

    }

    private void initWrapper() {
        Interpolator linearInterpolator = new LinearInterpolator();
        Drawable arrowW = getResources().getDrawable(R.mipmap.icon_loading_wraper);
        ivWrapper.setScaleType(ImageView.ScaleType.MATRIX);
        Matrix mHeaderImageMatrixWrapper = new Matrix();
        mHeaderImageMatrixWrapper.setRotate(180f, arrowW.getIntrinsicWidth() / 2f, arrowW.getIntrinsicHeight() / 2f);
        ivWrapper.setImageMatrix(mHeaderImageMatrixWrapper);
        Animation mRotateAnimationWrappers = new RotateAnimation(0, -720, Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF,
                0.5f);
        mRotateAnimationWrappers.setInterpolator(linearInterpolator);
        mRotateAnimationWrappers.setDuration(ROTATION_ANIMATION_DURATION);
        mRotateAnimationWrappers.setRepeatCount(Animation.INFINITE);
        mRotateAnimationWrappers.setRepeatMode(Animation.RESTART);
        ivWrapper.startAnimation(mRotateAnimationWrappers);
        ivWrapper.setVisibility(GONE);
    }

    private void initInterior() {
        ivInner.setScaleType(ImageView.ScaleType.MATRIX);
        Interpolator linearInterpolator = new LinearInterpolator();
        Drawable arrowW = getResources().getDrawable(R.mipmap.icon_loading_wraper);
        ivInner.setScaleType(ImageView.ScaleType.MATRIX);
        Matrix mHeaderImageMatrixWrapper = new Matrix();
        mHeaderImageMatrixWrapper.setRotate(180f, arrowW.getIntrinsicWidth() / 2f, arrowW.getIntrinsicHeight() / 2f);
        ivInner.setImageMatrix(mHeaderImageMatrixWrapper);
        Animation mRotateAnimationWrapper = new RotateAnimation(0, 720, Animation.RELATIVE_TO_SELF, 0.5f, Animation.RELATIVE_TO_SELF,
                0.5f);
        mRotateAnimationWrapper.setInterpolator(linearInterpolator);
        mRotateAnimationWrapper.setDuration(ROTATION_ANIMATION_DURATION);
        mRotateAnimationWrapper.setRepeatCount(Animation.INFINITE);
        mRotateAnimationWrapper.setRepeatMode(Animation.RESTART);
        ivInner.startAnimation(mRotateAnimationWrapper);
    }

    public void startAnimation() {
        init(mContext);

    }
}
