package com.zkty.engine.module.xxxx.view.widgets;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;
import android.util.AttributeSet;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.zkty.engine.module.xxxx.R;

import java.util.ArrayList;
import java.util.List;


/**
 * 此类的描述： 底部菜单栏
 *
 * @version:
 */
public class MyTabView extends RelativeLayout {
    private static final String TAG = "MyTabView";
    private int[] mDrawableIds;
    private int[] disDrawableIds;
    private List<TextView> mCheckedList = new ArrayList<>();
    private List<ImageView> mImageList = new ArrayList<ImageView>();
    private List<View> mViewList = new ArrayList<View>();

    private CharSequence[] mLabels;

    private int CHECKED_TEXTCOLOR = getContext().getResources().getColor(
            R.color.color_E8374A);

    private int UNCHECKED_TEXTCOLOR = getContext().getResources().getColor(
            R.color.color_12);
    public int size;

    public TextView textViewNumber;



    public interface OnTabSelectedListener {
        void onTabSelected(int index);
    }

    public void setOnTabSelectedListener(OnTabSelectedListener listener) {
        this.mTabListener = listener;
    }


    @SuppressLint("NewApi")
    public MyTabView(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(context);
    }

    public MyTabView(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public MyTabView(Context context) {
        super(context);
        init(context);
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    @SuppressWarnings("unused")
    public void init(final Context context) {

        View view = View.inflate(context, R.layout.layout_tab_view, this);


        mLabels = getResources().getTextArray(R.array.bottom_bar_labels_no_express);
        mDrawableIds = new int[]{R.mipmap.tabbar_button_1_2,
                R.mipmap.tabbar_button_3_2
                };

        disDrawableIds = new int[]{R.mipmap.tabbar_button_1_1,
                R.mipmap.tabbar_button_3_1};

        size = mLabels.length;
        mCheckedList.clear();
        mImageList.clear();
        mViewList.clear();

        TextView tv0 = view.findViewById(R.id.tv_tab_0);
        TextView tv1 = view.findViewById(R.id.tv_tab_1);


        ImageView iv0 = view.findViewById(R.id.iv_tab_0);
        ImageView iv1 = view.findViewById(R.id.iv_tab_1);
        ImageView iv2 = view.findViewById(R.id.iv_center);

        LinearLayout ll0 = view.findViewById(R.id.ll_tab_0);
        LinearLayout ll1 = view.findViewById(R.id.ll_tab_1);


        mCheckedList.add(tv0);
        mCheckedList.add(tv1);


        mImageList.add(iv0);
        mImageList.add(iv1);

        mViewList.add(ll0);
        mViewList.add(ll1);

        iv2.setOnClickListener(view1 -> {
            if (null != mTabListener) {
//                mTabListener.onTabSelected(2);
            }
        });


        for (int i = 0; i < size; i++) {
            final int index = i;
            mCheckedList.get(i).setText(mLabels[i]);
            mImageList.get(i).setImageResource(disDrawableIds[i]);

            mViewList.get(i).setOnClickListener(v -> {
                if (null != mTabListener) {
                    mTabListener.onTabSelected(index);
                }
            });

            if (i == 0) {
                mCheckedList.get(i).setTextColor(CHECKED_TEXTCOLOR);
                mImageList.get(i).setImageResource(mDrawableIds[i]);
            } else {

                mCheckedList.get(i).setTextColor(mDrawableIds[i]);
                mImageList.get(i).setImageResource(disDrawableIds[i]);
            }
        }
    }

    public void setTabsDisplay(Context context, int index, int msgCount) {
        int size = mCheckedList.size();
        for (int i = 0; i < size; i++) {
            TextView checkedTextView = mCheckedList.get(i);
            ImageView checkedImageView = mImageList.get(i);
            if (i == index) {
                checkedTextView.setTextColor(CHECKED_TEXTCOLOR);
                checkedImageView.setImageResource(mDrawableIds[index]);
            } else {

                checkedTextView.setTextColor(UNCHECKED_TEXTCOLOR);
                checkedImageView.setImageResource(disDrawableIds[i]);
            }
        }

    }


    private OnTabSelectedListener mTabListener;


}
