package com.zkty.modules.engine.view;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.drawable.GradientDrawable;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.util.AttributeSet;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;

import androidx.annotation.Nullable;

import com.bumptech.glide.Glide;
import com.zkty.modules.engine.utils.DensityUtils;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import module.engine.R;

import static android.content.Context.INPUT_METHOD_SERVICE;

public class SearchEditView extends LinearLayout {
    private Context mContext;
    private ImageView ivSearch;
    private ImageView ivClear;
    private EditText etKey;
    private String searchKey;
    private View root;
    private OnSearchClickListener mSearchClickListener;
    private boolean isInput = true;
    private LinearLayout llRoot;

    public SearchEditView(Context context) {
        super(context);
        initView(context);
    }


    public SearchEditView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        initView(context);
    }

    private void initView(Context context) {
        this.mContext = context;
        root = View.inflate(context, R.layout.layout_search_view, this);
        ivSearch = root.findViewById(R.id.iv_search_view_search);
        ivClear = root.findViewById(R.id.iv_search_view_clear);
        etKey = root.findViewById(R.id.et_search_view_key);
        llRoot = root.findViewById(R.id.ll_actionbar_search_content);
        initListener();
    }

    public void initViewData(Integer cornerRadius, String backgroundColor, String iconSearch, List<Double> iconSearchSize, String iconClear, List<Double> iconClearSize, String textColor, Integer fontSize, String placeHolder, boolean isInput, boolean becomeFirstResponder, OnSearchClickListener listener) {
        this.mSearchClickListener = listener;
        setBackground(backgroundColor, cornerRadius);
        setIvSearch(iconSearch, iconSearchSize);
        setIvClear(iconClear, iconClearSize);
        setEditText(textColor, fontSize, placeHolder, isInput, isFocused());


    }

    public void setOnSearchClickListener(OnSearchClickListener listener) {
        this.mSearchClickListener = listener;
    }

    private void initListener() {

        etKey.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable editable) {
                searchKey = editable.toString().trim();
                ivClear.setVisibility(TextUtils.isEmpty(searchKey) ? GONE : VISIBLE);

            }
        });


        etKey.setOnEditorActionListener((textView, actionId, keyEvent) -> {
            if (actionId == EditorInfo.IME_ACTION_SEARCH) {
                if (!TextUtils.isEmpty(searchKey) && mSearchClickListener != null) {
                    mSearchClickListener.onSearchClick(searchKey);
                    hideInput();
                }
                return true;
            }
            return false;

        });

        ivClear.setOnClickListener(view -> etKey.setText(""));
        ivSearch.setOnClickListener(view -> {
            if (mSearchClickListener != null && !TextUtils.isEmpty(searchKey)) {
                mSearchClickListener.onSearchClick(searchKey);
                hideInput();
            }
        });

    }

    public interface OnSearchClickListener {
        void onSearchClick(String key);
    }

    public void setIvSearch(String icon, List<Double> size) {
        setImage(ivSearch, icon, size);
    }

    public void setIvClear(String icon, List<Double> size) {
        setImage(ivClear, icon, size);
    }

    private void setImage(ImageView iv, String icon, List<Double> size) {
        if (size != null && size.size() == 2) {
            ViewGroup.LayoutParams lp = iv.getLayoutParams();
            lp.width = DensityUtils.dipToPixels(mContext, size.get(0) > 20 ? 20 : size.get(0));
            lp.height = DensityUtils.dipToPixels(mContext, size.get(0) > 20 ? 20 : size.get(0));
        }
        if (!TextUtils.isEmpty(icon)) {
            if (icon.toLowerCase().startsWith("http")) {
                Glide.with(mContext).load(icon).into(iv);
            } else {
                try (InputStream inputStream = mContext.getAssets().open("ModuleApp/com.zkty.module.nav.0" + icon)) {
                    Bitmap bitmap = BitmapFactory.decodeStream(inputStream);
                    iv.setImageBitmap(bitmap);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

    }

    public void setEditText(String textColor, int textSize, String hint, boolean isInput, boolean isFocused) {
        if (!TextUtils.isEmpty(textColor)) etKey.setTextColor(Color.parseColor(textColor));
        if (textSize > 0) etKey.setTextSize(Math.min(textSize, 16));
        if (!TextUtils.isEmpty(hint)) etKey.setHint(hint);
        this.isInput = isInput;
        showInput(isFocused);

    }

    @SuppressLint("WrongConstant")
    public void setBackground(String backgroundColor, int cornerRadius) {
        GradientDrawable drawable = new GradientDrawable();
        drawable.setShape(GradientDrawable.RECTANGLE);
        drawable.setGradientType(GradientDrawable.RECTANGLE);
        drawable.setCornerRadius(DensityUtils.dipToPixels(mContext, cornerRadius == 0 ? 25 : cornerRadius));
        drawable.setColor(Color.parseColor(TextUtils.isEmpty(backgroundColor) ? "#FAFAFA" : backgroundColor));
        llRoot.setBackground(drawable);

    }

    protected void hideInput() {
        InputMethodManager imm = (InputMethodManager) mContext.getSystemService(INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(etKey.getWindowToken(), 0);
    }

    public void showInput(boolean isFocused) {
        if (isFocused) {
            etKey.requestFocus();
            InputMethodManager imm = (InputMethodManager) mContext.getSystemService(INPUT_METHOD_SERVICE);
            imm.showSoftInput(etKey, InputMethodManager.SHOW_IMPLICIT);
        }
    }

    public EditText getEditText() {
        return this.etKey;
    }

}
