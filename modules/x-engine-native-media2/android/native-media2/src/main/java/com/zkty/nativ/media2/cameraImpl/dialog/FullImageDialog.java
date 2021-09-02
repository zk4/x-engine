package com.zkty.nativ.media2.cameraImpl.dialog;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.text.TextUtils;
import android.view.Display;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.TextView;

import androidx.viewpager.widget.ViewPager;

import com.gyf.barlibrary.ImmersionBar;
import com.zkty.nativ.media2.PreImageCallBack;
import com.zkty.nativ.media2.cameraImpl.adapter.ImagePreViewAdapter;
import com.zkty.nativ.media2.cameraImpl.data.MediaFile;
import com.zkty.nativ.media2.cameraImpl.view.HackyViewPager;

import java.util.ArrayList;
import java.util.List;

import module.media2.R;


/**
 * @author : MaJi
 * @time : (3/17/21)
 * dexc :查看大图
 */
public class FullImageDialog implements DialogInterface.OnDismissListener {

    HackyViewPager mViewPager;
    TextView mTvDrection;
    TextView indicator;
    public Context context;


    int index; // 索引
    private Dialog dialog;

    public FullImageDialog(Context context) {
        this.context = context;
        ImmersionBar.with((Activity) context)
                .fitsSystemWindows(true)
                .statusBarColor(R.color.black)
                .statusBarDarkFont(false).init();
    }

    public FullImageDialog Builder() {

        View view = LayoutInflater.from(context).inflate(
                R.layout.dialog_full_image, null);
        mViewPager = view.findViewById(R.id.vp_image_pager);
        mTvDrection = view.findViewById(R.id.tvDrection);
        indicator = view.findViewById(R.id.indicator);

        // 设置Dialog最小宽度为屏幕宽度
        WindowManager windowManager = (WindowManager) context
                .getSystemService(Context.WINDOW_SERVICE);
        Display display = windowManager.getDefaultDisplay();
        view.setMinimumWidth(display.getWidth());

        // 定义Dialog布局和参数
        dialog = new Dialog(context, R.style.MyDialog);
        dialog.setContentView(view);
        dialog.setOnDismissListener(this);
        Window dialogWindow = dialog.getWindow();
        dialogWindow.setGravity(Gravity.CENTER);
        WindowManager.LayoutParams lp = dialogWindow.getAttributes();
        lp.x = 0;
        lp.y = 0;
        dialogWindow.setAttributes(lp);

        return this;
    }

    /**
     * 设置单个图片
     *
     * @param url
     * @return
     */
    public FullImageDialog setUrl(String url) {
        ArrayList<MediaFile> mediaFileList = new ArrayList<>();//图片集合
        MediaFile mediaFile = new MediaFile();
        mediaFile.setPath(url);
        mediaFileList.add(mediaFile);
        setData(mediaFileList,index);
        return this;
    }

    /**
     * 设置图片集合
     *
     * @param mediaFile
     * @param index
     * @return
     */
    public FullImageDialog setImageMediaFile(MediaFile mediaFile, int index) {
        ArrayList<MediaFile> mediaFileList = new ArrayList<>();//图片集合
        mediaFileList.add(mediaFile);
        setData(mediaFileList,index);
        return this;
    }
    /**
     * 设置图片集合
     *
     * @param images
     * @param index
     * @return
     */
    public FullImageDialog setImageUrl(List<String> images, int index) {
        ArrayList<MediaFile> mediaFileList = new ArrayList<>();//图片集合
        for (String image : images) {
            MediaFile mediaFile = new MediaFile();
            mediaFile.setPath(image);
            mediaFileList.add(mediaFile);
        }
        setData(mediaFileList,index);
        return this;
    }

    /**
     * 设置图片集合
     *
     * @param mediaFileList
     * @param index
     * @return
     */
    public FullImageDialog setImageMediaFileList(List<MediaFile> mediaFileList, int index) {
        setData(mediaFileList,index);
        return this;
    }

    /**
     * 设置数据
     * @param images
     * @param index
     */
    private void setData(List<MediaFile> images,int index){
        if (images != null && images.size() > 0) {
            ImagePreViewAdapter imagePagerAdapter = new ImagePreViewAdapter(context, images);
            mViewPager.setAdapter(imagePagerAdapter);
            if (index != 0 && index <= images.size()) {
                mViewPager.setCurrentItem(index);
                index += 1;
                indicator.setText(index + "/" + mViewPager.getAdapter().getCount());
            }
            imagePagerAdapter.setOnSingleClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    dialog.dismiss();
                }
            });
            mViewPager.addOnPageChangeListener(new ViewPager.SimpleOnPageChangeListener() {
                @Override
                public void onPageSelected(int arg0) {
                    arg0 += 1;
                    indicator.setText(arg0 + "/" + mViewPager.getAdapter().getCount());
                }
            });
        } else {
            dialog.dismiss();
        }
    }


    /**
     * 设置标题
     *
     * @param drection
     * @return
     */
    public FullImageDialog setDrection(String drection) {
        if (!TextUtils.isEmpty(drection)) {
            mTvDrection.setText(drection);
        }
        return this;
    }

    /**
     * 弹窗关闭监听
     * @param dialog
     */
    PreImageCallBack callBack;
    public FullImageDialog setOnDismissListener(PreImageCallBack callBack) {
        this.callBack = callBack;
        return this;
    }

    public void show() {
        dialog.show();
    }

    @Override
    public void onDismiss(DialogInterface dialog) {
        ImmersionBar.with((Activity) context)
                .fitsSystemWindows(true)
                .statusBarColor(R.color.white)
                .statusBarDarkFont(true).init();
        ImmersionBar.with((Activity) context).destroy();
        if(null != callBack){
            callBack.closeCallBack();
        }
    }

}
