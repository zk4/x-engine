package com.zkty.modules.engine.view;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.text.TextUtils;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.alibaba.fastjson.JSON;
import com.bumptech.glide.Glide;
import com.zkty.modules.engine.utils.DensityUtils;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import module.engine.R;

public class XEngineNavBar extends RelativeLayout {

    private Context mContext;
    private View root;
    private TextView titleTv;
    private TextView leftTv, rightTv, menuTv;
    private ImageView leftIv, rightIv, menuIv;
    private LinearLayout layoutLeft, layoutRight, layoutMenu;
    private SearchEditView searchEditView;
    private RecyclerView layoutMore;


    public XEngineNavBar(Context context) {
        super(context);
        init(context);
    }

    public XEngineNavBar(Context context, AttributeSet attrs) {
        super(context, attrs);
        init(context);
    }

    private void init(Context context) {
        this.mContext = context;
        root = View.inflate(context, R.layout.layout_nav_bar, this);
        titleTv = root.findViewById(R.id.tv_action_bar_title);
        leftTv = root.findViewById(R.id.tv_actionbar_left);
        rightTv = root.findViewById(R.id.tv_actionbar_right);
        menuTv = root.findViewById(R.id.tv_actionbar_menu);
        leftIv = root.findViewById(R.id.iv_actionbar_left);
        rightIv = root.findViewById(R.id.iv_actionbar_right);
        menuIv = root.findViewById(R.id.iv_actionbar_menu);
        layoutLeft = root.findViewById(R.id.ll_actionbar_left);
        layoutRight = root.findViewById(R.id.ll_actionbar_right);
        layoutMenu = root.findViewById(R.id.ll_actionbar_menu);
        searchEditView = root.findViewById(R.id.ll_actionbar_search);
        layoutMore = root.findViewById(R.id.hl_actionbar_right_more);

    }


    public void setTitle(String title, String titleColor, Integer titleSize) {
        titleTv.setText(title);
        if (!TextUtils.isEmpty(titleColor))
            titleTv.setTextColor(Color.parseColor(titleColor));
        if (titleSize != null && titleSize > 0) {
            titleTv.setTextSize(titleSize);
        }

    }

    public void setNavLeftBtn(String title, String titleColor, Integer titleSize, String icon, List<Double> iconSize, boolean isBold, OnClickListener listener) {
        setClickView(true, leftTv, leftIv, title, titleColor, titleSize, icon, iconSize, isBold);
        if (listener != null) {
            layoutLeft.setOnClickListener(listener);
        }

    }

    public void setLeftListener(OnClickListener listener) {
        layoutLeft.setOnClickListener(listener);
    }

    public void setNavRightBtn(String title, String titleColor, Integer titleSize, String icon, List<Double> iconSize, boolean isBold, OnClickListener listener) {
        layoutMore.setVisibility(GONE);
        layoutMenu.setVisibility(GONE);
        setClickView(false, rightTv, rightIv, title, titleColor, titleSize, icon, iconSize, isBold);
        layoutRight.setOnClickListener(listener);
        layoutRight.setVisibility(VISIBLE);
    }

    public void setNavRightMoreBtn(String params, AdapterView.OnItemClickListener listener) {
        layoutRight.setVisibility(GONE);
        layoutMenu.setVisibility(GONE);
        List<NavBtnDTO> mList = JSON.parseArray(params, NavBtnDTO.class);
        LinearLayoutManager layoutManager = new LinearLayoutManager(mContext);
        layoutManager.setOrientation(LinearLayoutManager.HORIZONTAL);
        layoutMore.setLayoutManager(layoutManager);
        MoreBtnAdapter adapter = new MoreBtnAdapter(mList);
        layoutMore.setAdapter(adapter);
        layoutMore.setVisibility(VISIBLE);

    }


    public void setNavRightMenuBtn(String title, String titleColor, Integer titleSize, String icon, List<Double> iconSize, List<Map<String, String>> itemList, boolean showMenuImg, String menuWidth, AdapterView.OnItemClickListener listener) {
        layoutRight.setVisibility(GONE);
        layoutMore.setVisibility(GONE);
        setClickView(false, menuTv, menuIv, title, titleColor, titleSize, icon, iconSize, false);
        layoutMenu.setVisibility(VISIBLE);
        layoutMenu.setOnClickListener(view -> showMenu(itemList, showMenuImg, menuWidth, listener));
    }

    public void setNavSearchBar(Integer cornerRadius, String backgroundColor, String iconSearch, List<Double> iconSearchSize, String iconClear, List<Double> iconClearSize, String textColor, Integer fontSize, String placeHolder, boolean isInput, boolean becomeFirstResponder, SearchEditView.OnSearchClickListener listener) {
        searchEditView.initViewData(cornerRadius, backgroundColor, iconSearch, iconSearchSize, iconClear, iconClearSize, textColor, fontSize, placeHolder, isInput, becomeFirstResponder, listener);
        searchEditView.setVisibility(VISIBLE);
    }

    private void showMenu(List<Map<String, String>> itemList, boolean showMenuImg, String menuWidth, AdapterView.OnItemClickListener listener) {
        int with = 0;
        if (TextUtils.isEmpty(menuWidth)) {
            with = 100;
        } else {
            with = Integer.parseInt(menuWidth);
        }

        View contentView = View.inflate(mContext, R.layout.layout_action_menu, null);
        PopupWindow window = new PopupWindow(contentView, DensityUtils.dipToPixels(mContext, with), LayoutParams.WRAP_CONTENT, true);
        ListView mListView = contentView.findViewById(R.id.menu_list);
        mListView.setAdapter(new BaseAdapter() {
            @Override
            public int getCount() {
                return itemList.size();
            }

            @Override
            public Object getItem(int i) {
                return null;
            }

            @Override
            public long getItemId(int i) {
                return 0;
            }

            @Override
            public View getView(int i, View view, ViewGroup viewGroup) {
                ViewHolder holder = null;
                if (view == null) {
                    holder = new ViewHolder();
                    view = View.inflate(mContext, R.layout.item_menu, null);
                    holder.tvTitle = view.findViewById(R.id.tv_menu_item);
                    holder.ivIcon = view.findViewById(R.id.iv_menu_item);
                    view.setTag(holder);
                } else {
                    holder = (ViewHolder) view.getTag();
                }

                if (showMenuImg && itemList.get(i).containsKey("icon")) {
                    setImage(holder.ivIcon, Objects.requireNonNull(itemList.get(i).get("icon")));

                }
                holder.tvTitle.setText(itemList.get(i).get("title"));

                return view;
            }
        });
        mListView.setOnItemClickListener((adapterView, view, i, l) -> {
            listener.onItemClick(adapterView, view, i, l);
            window.dismiss();
        });

        window.showAsDropDown(layoutMenu);
    }

    private class ViewHolder {
        private TextView tvTitle;
        private ImageView ivIcon;
    }

    private void setClickView(boolean isLeft, TextView tv, ImageView iv, String title, String titleColor, Integer titleSize, String icon, List<Double> iconSize, boolean isBold) {
        if (!TextUtils.isEmpty(title)) {
            tv.setText(title);
            tv.setTextColor(Color.parseColor(titleColor));
            if (titleSize != null && titleSize > 9 && titleSize < 17) {
                tv.setTextSize(titleSize);
            }
            if (isBold) {
                Typeface font = Typeface.create(Typeface.SANS_SERIF, Typeface.BOLD);
                tv.setTypeface(font);
            }

            tv.setVisibility(View.VISIBLE);
        } else {
            tv.setVisibility(GONE);
        }
        if (!TextUtils.isEmpty(icon) && TextUtils.isEmpty(title)) {//Object中如果同时存在title和icon会默认显示文字?
            if (iconSize != null && iconSize.size() == 2) {
                ViewGroup.LayoutParams lp = iv.getLayoutParams();
                lp.width = DensityUtils.dipToPixels(mContext, iconSize.get(0));
                lp.height = DensityUtils.dipToPixels(mContext, iconSize.get(1));
            }
            setImage(iv, icon);
        } else {
            if (!isLeft)
                iv.setVisibility(GONE);
        }
    }

    private void setImage(ImageView iv, String icon) {
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
        iv.setVisibility(View.VISIBLE);
    }

    class MoreBtnAdapter extends RecyclerView.Adapter<MyViewHolder> {
        private List<NavBtnDTO> mList;

        public MoreBtnAdapter(List<NavBtnDTO> mList) {
            this.mList = mList;
        }

        @NonNull
        @Override
        public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.item_right_btn_more, parent, false);
            MyViewHolder holder = new MyViewHolder(view);

            return holder;

        }

        @Override
        public void onBindViewHolder(@NonNull MyViewHolder holder, int position) {
            NavBtnDTO dto = mList.get(position);
            if (TextUtils.isEmpty(dto.title)) {
                if (!TextUtils.isEmpty(dto.icon)) {
                    if (dto.iconSize != null && dto.iconSize.size() == 2) {
                        ViewGroup.LayoutParams lp = holder.ivImage.getLayoutParams();
                        lp.width = DensityUtils.dipToPixels(mContext, dto.iconSize.get(0));
                        lp.height = DensityUtils.dipToPixels(mContext, dto.iconSize.get(1));
                    }
                    setImage(holder.ivImage, dto.icon);
                }

            } else {
                holder.tvTitle.setVisibility(VISIBLE);
                holder.tvTitle.setText(dto.title);
                holder.tvTitle.setTextColor(Color.parseColor(TextUtils.isEmpty(dto.titleColor) ? "#343434" : dto.titleColor));
                if (dto.titleSize != null && dto.titleSize > 9 && dto.titleSize < 17) {
                    holder.tvTitle.setTextSize(dto.titleSize);
                }
            }

        }

        @Override
        public int getItemCount() {
            return mList.size();
        }
    }

    class MyViewHolder extends RecyclerView.ViewHolder {
        TextView tvTitle;
        ImageView ivImage;
        View root;

        public MyViewHolder(@NonNull View itemView) {
            super(Objects.requireNonNull(itemView));
            root = itemView;
            tvTitle = itemView.findViewById(R.id.tv_right_more_item);
            ivImage = itemView.findViewById(R.id.iv_right_more_item);
        }
    }

    public static class NavBtnDTO {
        public String title;
        public String titleColor;
        public Integer titleSize;
        public String icon;
        public List<Double> iconSize;

    }

    public void setLeftTitle(String title) {
        leftTv.setText(title);
        leftTv.setVisibility(VISIBLE);
    }

    public ImageView getLiftIv() {
        return leftIv;

    }

    public SearchEditView getSearchEditView() {
        return searchEditView;
    }
}
