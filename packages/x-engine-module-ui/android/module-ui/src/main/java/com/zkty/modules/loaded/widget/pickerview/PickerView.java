package com.zkty.modules.loaded.widget.pickerview;

import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;

import java.util.ArrayList;
import java.util.List;

import module.ui.R;

public class PickerView extends Dialog {


    private Params params;

    public PickerView(Context context, int themeResId) {
        super(context, themeResId);
    }

    private void setParams(Params params) {
        this.params = params;
    }

    public interface OnDataSelectedListener {
        void onDataSelected(List<String> data);

        void onCancel();
    }


    private static final class Params {
        private boolean shadow = true;
        private boolean canCancel = true;
        private LoopView loop1, loop2, loop3, loop4;
        private OnDataSelectedListener callback;
    }

    public static class Builder {
        private final Context context;
        private final Params params;
        private List<List<String>> data;
        private String toolBarColor;
        private String pickerBackgroundColor;
        private String backgroundColor;
        private String backgroundColorAlpha;
        private int pickerHeight;
        private int rowHeight;
        private String leftText;
        private String leftTextColor;
        private int leftTextSize;
        private String rightText;
        private String rightTextColor;
        private int rightTextSize;

        public Builder(Context context) {
            this.context = context;
            params = new Params();
        }

        public Builder setData(List<List<String>> data) {
            this.data = data;
            return this;
        }

        public Builder setToolBarColor(String toolBarColor) {
            this.toolBarColor = toolBarColor;
            return this;
        }

        public Builder setPickerBackgroundColor(String pickerBackgroundColor) {
            this.pickerBackgroundColor = pickerBackgroundColor;
            return this;
        }

        public Builder setBackgroundColor(String backgroundColor) {
            this.backgroundColor = backgroundColor;
            return this;
        }

        public Builder setBackgroundColorAlpha(String backgroundColorAlpha) {
            this.backgroundColorAlpha = backgroundColorAlpha;
            return this;
        }

        public Builder setPickerHeight(int pickerHeight) {
            this.pickerHeight = pickerHeight;
            return this;
        }

        public Builder setRowHeight(int rowHeight) {
            this.rowHeight = rowHeight;
            return this;
        }

        public Builder setLeftText(String leftText) {
            this.leftText = leftText;
            return this;
        }

        public Builder setLeftTextColor(String leftTextColor) {
            this.leftTextColor = leftTextColor;
            return this;
        }

        public Builder setLeftTextSize(int leftTextSize) {
            this.leftTextSize = leftTextSize;
            return this;
        }

        public Builder setRightText(String rightText) {
            this.rightText = rightText;
            return this;
        }

        public Builder setRightTextColor(String rightTextColor) {
            this.rightTextColor = rightTextColor;
            return this;
        }

        public Builder setRightTextSize(int rightTextSize) {
            this.rightTextSize = rightTextSize;
            return this;
        }

        /**
         * 获取当前选择的日期
         *
         * @return int[]数组形式返回。例[1990,6,15]
         */
        private final List<String> getCurrDateValues() {
            List<String> result = new ArrayList<>();
            if (data.size() > 0) {
                result.add(params.loop1.getCurrentItemValue());
            }
            if (data.size() > 1) {
                result.add(params.loop2.getCurrentItemValue());
            }
            if (data.size() > 2) {
                result.add(params.loop3.getCurrentItemValue());
            }
            if (data.size() > 3) {
                result.add(params.loop4.getCurrentItemValue());
            }
            return result;


        }

        public Builder setOnDateSelectedListener(OnDataSelectedListener onDataSelectedListener) {
            params.callback = onDataSelectedListener;
            return this;
        }


        public PickerView create() {
            final PickerView dialog = new PickerView(context, params.shadow ? R.style.Theme_Light_NoTitle_Dialog : R.style.Theme_Light_NoTitle_NoShadow_Dialog);
            View view = LayoutInflater.from(context).inflate(R.layout.layout_picker_date, null);

            view.findViewById(R.id.tv_cancel).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    dialog.dismiss();
                    params.callback.onCancel();
                }
            });

            setDialogStyle(view);

            LoopView loop1 = (LoopView) view.findViewById(R.id.loop_1);
            loop1.setArrayList(data.get(0));
            params.loop1 = loop1;

            if (data.size() > 1) {
                view.findViewById(R.id.fl_2).setVisibility(View.VISIBLE);
                LoopView loop2 = (LoopView) view.findViewById(R.id.loop_2);
                loop2.setArrayList(data.get(1));
                params.loop2 = loop2;
            }
            if (data.size() > 2) {
                view.findViewById(R.id.fl_3).setVisibility(View.VISIBLE);
                LoopView loop3 = (LoopView) view.findViewById(R.id.loop_3);
                loop3.setArrayList(data.get(2));
                params.loop3 = loop3;
            }
            if (data.size() > 3) {
                view.findViewById(R.id.fl_4).setVisibility(View.VISIBLE);
                LoopView loop4 = (LoopView) view.findViewById(R.id.loop_4);
                loop4.setArrayList(data.get(3));
                params.loop4 = loop4;
            }


            view.findViewById(R.id.tx_finish).setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    dialog.dismiss();
                    params.callback.onDataSelected(getCurrDateValues());
                }
            });

            Window win = dialog.getWindow();
            win.getDecorView().setPadding(0, 0, 0, 0);
            WindowManager.LayoutParams lp = win.getAttributes();
            lp.width = WindowManager.LayoutParams.MATCH_PARENT;
            lp.height = WindowManager.LayoutParams.WRAP_CONTENT;
            win.setAttributes(lp);
            win.setGravity(Gravity.BOTTOM);
            win.setWindowAnimations(R.style.Animation_Bottom_Rising);
            dialog.setContentView(view);
            dialog.setCanceledOnTouchOutside(params.canCancel);
            dialog.setCancelable(params.canCancel);

            dialog.setParams(params);

            return dialog;
        }

        private void setDialogStyle(View view) {
            if (!TextUtils.isEmpty(toolBarColor))
                view.findViewById(R.id.rl_toolbar).setBackgroundColor(Color.parseColor(toolBarColor));
        }


    }
}
