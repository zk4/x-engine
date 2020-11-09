package com.zkty.demo.pedestal;

import android.annotation.SuppressLint;
import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.CheckedTextView;
import android.widget.ImageView;
import android.widget.LinearLayout;

import java.util.ArrayList;
import java.util.List;

/**
 * 此类的描述： 底部菜单栏
 *
 * @version:
 */
public class MyTabWidget extends LinearLayout {
    private static final String TAG = "MyTabWidget";
    private int[] mDrawableIds;
    private int[] disDrawableIds;
    private List<CheckedTextView> mCheckedList = new ArrayList<CheckedTextView>();
    private List<ImageView> mImageList = new ArrayList<ImageView>();
    private List<View> mViewList = new ArrayList<View>();

    private CharSequence[] mLabels;

    private int CHECKED_TEXTCOLOR = getContext().getResources().getColor(
            R.color.color_E8374A);

    private int UNCHECKED_TEXTCOLOR = getContext().getResources().getColor(
            R.color.color_8d8d8d);
    public int size;

    @SuppressLint("NewApi")
    public MyTabWidget(Context context, AttributeSet attrs, int defStyle) {
        super(context, attrs, defStyle);
        init(context);
    }

    public MyTabWidget(Context context, AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public MyTabWidget(Context context) {
        super(context);
        init(context);
    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN)
    @SuppressWarnings("unused")
    public void init(final Context context) {
        this.setOrientation(LinearLayout.HORIZONTAL);
        this.setGravity(Gravity.BOTTOM);
        LayoutInflater inflater = LayoutInflater.from(context);
        LayoutParams params = new LayoutParams(
                LayoutParams.WRAP_CONTENT, LayoutParams.WRAP_CONTENT);
        params.weight = 1.0f;
        mLabels = getResources().getTextArray(R.array.bottom_bar_labels_no_express);
        mDrawableIds = new int[]{R.mipmap.tabbar_button_1_2,
                R.mipmap.tabbar_button_2_2,
                R.mipmap.tabbar_button_3_2
        };

        disDrawableIds = new int[]{R.mipmap.tabbar_button_1_1,
                R.mipmap.tabbar_button_2_1,
                R.mipmap.tabbar_button_3_1
        };

        size = mLabels.length;
        mCheckedList.clear();
        mImageList.clear();
        mViewList.clear();
        for (int i = 0; i < size; i++) {
            final int index = i;
            final View view = inflater.inflate(R.layout.tab_item, null);
            final CheckedTextView itemName = (CheckedTextView) view
                    .findViewById(R.id.item_name);
            if (size == 1) {
                itemName.setVisibility(View.GONE);
            }

            final ImageView itemImage = view.findViewById(R.id.item_img);
            itemImage.setImageResource(mDrawableIds[i]);
            itemName.setText(mLabels[i]);
            this.addView(view, params);
            itemName.setTag(index);
            mCheckedList.add(itemName);
            mImageList.add(itemImage);
            mViewList.add(view);
            view.setOnClickListener(v -> {
                if (null != mTabListener) {
                    mTabListener.onTabSelected(index);
                }
            });

            if (i == 0) {
                itemName.setChecked(true);
                itemName.setTextColor(CHECKED_TEXTCOLOR);
            } else {
                itemName.setChecked(false);
                itemName.setTextColor(UNCHECKED_TEXTCOLOR);
            }
        }
    }


    public void setTabsDisplay(Context context, int index, int msgCount) {

        int size = mCheckedList.size();
        for (int i = 0; i < size; i++) {
            CheckedTextView checkedTextView = mCheckedList.get(i);
            ImageView checkedImageView = mImageList.get(i);
            if (i == index) {
                // PltpLogs.LOGD(TAG, mLabels[index] + " is selected...");
                checkedTextView.setChecked(true);
                checkedTextView.setTextColor(CHECKED_TEXTCOLOR);
                checkedImageView.setImageResource(mDrawableIds[index]);
            } else {
                checkedTextView.setChecked(false);
                checkedTextView.setTextColor(UNCHECKED_TEXTCOLOR);
                checkedImageView.setImageResource(disDrawableIds[i]);
            }
        }

    }

    private OnTabSelectedListener mTabListener;

    public interface OnTabSelectedListener {
        void onTabSelected(int index);
    }

    public void setOnTabSelectedListener(OnTabSelectedListener listener) {
        this.mTabListener = listener;
    }

}
