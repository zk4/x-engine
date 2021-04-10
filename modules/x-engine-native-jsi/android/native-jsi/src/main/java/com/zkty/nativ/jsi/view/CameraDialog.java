package com.zkty.nativ.jsi.view;

import android.annotation.TargetApi;
import android.app.AlertDialog;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.res.Resources;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.TextView;

import nativ.jsi.R;


/**
 * 弹窗
 */
public class CameraDialog implements AdapterView.OnItemClickListener, View.OnClickListener {

    private AlertDialog alertDialog;
    private AlertDialog.Builder mBuilder;
    private LayoutInflater mLayoutInflater;
    private ListView listView;

    private Resources resources;
    private Context mContext;
    private View view;
    private TextView cancelButton;

    private BottomDialogOnClickListener mcallback;
    private String[] mArr;

    public CameraDialog(Context context) {
        mContext = context;
        resources = context.getResources();
        mBuilder = new AlertDialog.Builder(context);
        mLayoutInflater = LayoutInflater.from(context);
        view = mLayoutInflater.inflate(R.layout.bottom_dialog_camera_view, null);
        listView = (ListView) view.findViewById(R.id.za_dialog_collection);
        cancelButton = (TextView) view.findViewById(R.id.za_btn_cancel);

        cancelButton.setOnClickListener(this);
    }

    @Override
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
        mcallback.onClickBackListener(view, i, l);
        dismissDialog();
    }


    public void initDialog( String[] items, BottomDialogOnClickListener listener) {

        mcallback = listener;
        mArr = items;
        ListAdapter adapter = new MyListAdapter();
        listView.setAdapter(adapter);
        listView.setOnItemClickListener(this);

        alertDialog = mBuilder.create();
        alertDialog.getWindow().setGravity(Gravity.BOTTOM);
        // alertDialog.getWindow().setWindowAnimations(R.style.dialogWindowAnim);
        alertDialog.setCanceledOnTouchOutside(false);
        setDialogWidth(alertDialog, mContext, 25);
    }


    public void showDialog() {
        //if (isShowing) {
        //    return;
        //}
        //isShowing = true;
        alertDialog.getWindow().setBackgroundDrawableResource(android.R.color.transparent);
        alertDialog.show();
        alertDialog.getWindow().setContentView(view);
    }

    public void dismissDialog() {
        alertDialog.dismiss();
        //isShowing = false;
    }

    //是否隐藏button
    public void enableButton(boolean cancel) {
        //cancelButton.setText(resources.getString(contentCancel));
        cancelButton.setVisibility(cancel ? View.VISIBLE : View.GONE);
    }

    //button设置背景
    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    public void setZACancelButtonBG(int resourcesId) {
        cancelButton.setBackground(resources.getDrawable(resourcesId));
    }

    @Override
    public void onClick(View view) {
        int btnId = view.getId();
        if (R.id.za_btn_cancel == btnId) {
            mcallback.onClickBackListener(view, -2, 0);
        }
        dismissDialog();
    }

    public interface BottomDialogOnClickListener {
        void onClickBackListener(View view, int which, long l);
    }

    public void setOnDialogDismissListener(DialogInterface.OnDismissListener listener) {
        alertDialog.setOnDismissListener(listener);
    }

    /**
     * //设置弹出框宽度
     *
     * @param dialog       对话框对象
     * @param context      上下文对象
     * @param marginValues 弹出框居左距右距离设定
     **/
    public void setDialogWidth(Dialog dialog, Context context, int marginValues) {
        Window dialogWindow = dialog.getWindow();
        //获取屏幕大小
        if (context == null) {
            return;
        }
        WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        int width = wm.getDefaultDisplay().getWidth();//屏幕宽度

        WindowManager.LayoutParams lp = dialogWindow.getAttributes();

        lp.width = width - marginValues;//marginValues这个值设置越大。弹窗窗口越小。
        lp.height = WindowManager.LayoutParams.WRAP_CONTENT;
        dialogWindow.setBackgroundDrawable(new ColorDrawable(Color.parseColor("#44000000")));

        dialogWindow.setGravity(Gravity.BOTTOM);
        dialogWindow.setAttributes(lp);
    }


    public class MyListAdapter extends BaseAdapter {

        @Override
        public int getCount() {
            return mArr.length;
        }

        @Override
        public Object getItem(int i) {
            return mArr[i];
        }

        @Override
        public long getItemId(int i) {
            return i;
        }

        @Override
        public View getView(int i, View view, ViewGroup viewGroup) {
            View view1 = mLayoutInflater.inflate(R.layout.camera_dialog_item, null);
            TextView tvContent1 = view1.findViewById(R.id.tv_content);
            String title = mArr[i];
            tvContent1.setText(title);

            return view1;
        }


    }

}
