package com.zkty.nativ.viewer_original.activity;

import android.content.Intent;
import android.os.Bundle;

import androidx.annotation.Nullable;

import com.github.barteksc.pdfviewer.PDFView;
import com.github.barteksc.pdfviewer.scroll.DefaultScrollHandle;
import com.github.barteksc.pdfviewer.util.FitPolicy;
import com.gyf.barlibrary.ImmersionBar;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.XEngineNavBar;

import java.io.File;

import module.viewer_original.R;

/**
 * @author : MaJi
 * @time : (8/20/21)
 * dexc :
 */
public class PrePdfViewActivity extends BaseXEngineActivity {
    private XEngineNavBar mXEngineNavBar;
    private String filePath;
    private String fileType;
    private String title;
    private PDFView mPDFView;

    public static void startAty(String filePath, String title, String fileType) {
        Intent intent = new Intent(XEngineApplication.getCurrentActivity(), PrePdfViewActivity.class);
        intent.putExtra(PreViewActivity.FILE_PATH,filePath);
        intent.putExtra(PreViewActivity.FILE_TYPE,fileType);
        intent.putExtra(PreViewActivity.TITLE,title);
        XEngineApplication.getCurrentActivity().startActivity(intent);
    }


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        ImmersionBar.with(this)
                .fitsSystemWindows(true)
                .statusBarColor(R.color.white)
                .statusBarDarkFont(true).init();
        setContentView(R.layout.activity_pre_pdf_view_file);
        filePath = getIntent().getStringExtra(PreViewActivity.FILE_PATH);
        fileType = getIntent().getStringExtra(PreViewActivity.FILE_TYPE);
        title= getIntent().getStringExtra(PreViewActivity.TITLE);

        mXEngineNavBar = findViewById(R.id.mXEngineNavBar);
        mXEngineNavBar.setLeftListener(v -> finish());
        //设置标题
        mXEngineNavBar.setTitle(title,null,null);
        mPDFView = findViewById(R.id.mPDFView);


        mPDFView.fromFile(new File(filePath))
                .enableSwipe(true)
                .swipeHorizontal(false)
                .enableDoubletap(true)
                .defaultPage(0)
                .enableAnnotationRendering(false)
                .password(null)
                .scrollHandle(new DefaultScrollHandle(this))
                .enableAntialiasing(true)
                .spacing(0)
                .autoSpacing(false)
                .pageFitPolicy(FitPolicy.WIDTH)
                .fitEachPage(false)
                .pageSnap(false)
                .pageFling(false)
                .nightMode(false)
                .load();

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        ImmersionBar.with(this).destroy();
    }
}

