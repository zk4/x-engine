package com.zkty.nativ.media.cameraImpl.view;

import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.View;
import android.widget.PopupWindow;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.zkty.nativ.media.cameraImpl.adapter.ImageFoldersAdapter;
import com.zkty.nativ.media.cameraImpl.data.MediaFolder;
import com.zkty.nativ.media.cameraImpl.utils.Utils;

import java.util.List;

import module.media.R;


public class ImageFolderPopupWindow extends PopupWindow {

    private static final int DEFAULT_IMAGE_FOLDER_SELECT = 0;//默认选中文件夹

    private Context mContext;
    private List<MediaFolder> mMediaFolderList;

    private RecyclerView mRecyclerView;
    private ImageFoldersAdapter mImageFoldersAdapter;

    public ImageFolderPopupWindow(Context context, List<MediaFolder> mediaFolderList) {
        this.mContext = context;
        this.mMediaFolderList = mediaFolderList;
        initView();

    }

    /**
     * 初始化布局
     */
    private void initView() {
        View view = LayoutInflater.from(mContext).inflate(R.layout.window_image_folders, null);
        mRecyclerView = view.findViewById(R.id.rv_main_imageFolders);
        mRecyclerView.setLayoutManager(new LinearLayoutManager(mContext));
        mImageFoldersAdapter = new ImageFoldersAdapter(mContext, mMediaFolderList, DEFAULT_IMAGE_FOLDER_SELECT);
        mRecyclerView.setAdapter(mImageFoldersAdapter);

        initPopupWindow(view);
    }

    /**
     * 初始化PopupWindow的一些属性
     */
    private void initPopupWindow(View view) {
        setContentView(view);
        int[] screenSize = Utils.getScreenSize(mContext);
        setWidth(screenSize[0]);
        setHeight((int) (screenSize[1] * 0.6));
        setBackgroundDrawable(new ColorDrawable());
        setOutsideTouchable(true);
        setFocusable(true);
        setTouchInterceptor(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View view, MotionEvent motionEvent) {
                if (motionEvent.getAction() == MotionEvent.ACTION_OUTSIDE) {
                    dismiss();
                }
                return false;
            }
        });
    }

    public ImageFoldersAdapter getAdapter() {
        return mImageFoldersAdapter;
    }

}
