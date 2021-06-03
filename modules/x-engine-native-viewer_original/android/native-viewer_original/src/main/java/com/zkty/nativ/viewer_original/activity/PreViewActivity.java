package com.zkty.nativ.viewer_original.activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;

import androidx.annotation.Nullable;

import com.tencent.smtt.sdk.TbsReaderView;
import com.zkty.nativ.core.XEngineApplication;
import com.zkty.nativ.core.utils.ToastUtils;
import com.zkty.nativ.jsi.view.BaseXEngineActivity;
import com.zkty.nativ.jsi.view.XEngineNavBar;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import module.viewer_original.R;


/**
 * @author : MaJi
 * @time : (5/13/21)
 * dexc :
 */
public class PreViewActivity extends BaseXEngineActivity {

    public static final String FILE_PATH = "filePath";
    public static final String FILE_NAME = "fileName";
    public static final String FILE_TYPE = "fileType";
    public static final String TITLE = "title";
    private LinearLayout llContent;
    private XEngineNavBar mXEngineNavBar;
    private TbsReaderView tbsReaderView;
    private String filePath,downLoadUrl;
    private String fileType;
    private String title;

    public static void startAty(String filePath, String title, String fileType) {
        Intent intent = new Intent(XEngineApplication.getCurrentActivity(), PreViewActivity.class);
        intent.putExtra(PreViewActivity.FILE_PATH,filePath);
        intent.putExtra(PreViewActivity.FILE_TYPE,fileType);
        intent.putExtra(PreViewActivity.TITLE,title);
        XEngineApplication.getCurrentActivity().startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_preview_file);

        filePath = getIntent().getStringExtra(FILE_PATH);
        fileType = getIntent().getStringExtra(FILE_TYPE);
        title= getIntent().getStringExtra(TITLE);



        llContent = findViewById(R.id.llContent);
        mXEngineNavBar = findViewById(R.id.mXEngineNavBar);

        List<Double> iconSize = new ArrayList<>();
        iconSize.add(20.0);
        iconSize.add(20.0);
        Map<String,String> map = new HashMap<>();
        map.put("title","分享");
        Map<String,String> map1 = new HashMap<>();
        map1.put("title","更多");
        List<Map<String,String> > itemlist = new ArrayList<>();
        itemlist.add(map);
        itemlist.add(map1);

        mXEngineNavBar.setNavRightMenuBtn("更多", "#121212", null, null, iconSize, itemlist, false, "100", new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                ToastUtils.showCenterToast(itemlist.get(position).get("title"));
            }
        });
        mXEngineNavBar.setLeftListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

        //设置标题
        mXEngineNavBar.setTitle(title,null,null);
        //打开文件
        openFile(filePath, fileType);
    }


    /**
     * 打开文件
     * @param path
     */
    private void openFile(String path,String fileType) {
        tbsReaderView = new TbsReaderView(this, readerCallback);
        llContent.addView(tbsReaderView,new RelativeLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        Bundle bundle = new Bundle();
        //文件路径
        bundle.putString("filePath", path);
        //临时文件的路径，必须设置，否则会报错
        bundle.putString("tempPath", Environment.getExternalStorageDirectory().getAbsolutePath()+"腾讯文件TBS");
        //准备
        boolean result = tbsReaderView.preOpen(fileType, false);
        if (result) {
            //预览文件
            tbsReaderView.openFile(bundle);
        }
    }


    /**
     * 下面的回调必须要实现，暂时没找到此回调的用处
     */
    TbsReaderView.ReaderCallback readerCallback = new TbsReaderView.ReaderCallback() {
        @Override
        public void onCallBackAction(Integer integer, Object o, Object o1) {

        }
    };

    @Override
    protected void onDestroy() {
        super.onDestroy();
        //需要将预览服务停止，一定不要忘了
        if(tbsReaderView != null){
            tbsReaderView.onStop();
        }
    }

}
