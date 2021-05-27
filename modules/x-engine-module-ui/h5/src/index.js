// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


import xengine from "@zkty-team/x-engine-module-engine";
import mock from "./mock";
function osCheck() {
  if (false) {
    return mock;
} 
  else {

    return  xengine.use("com.zkty.module.ui", 
    [
  {
    "name": "showToast",
    "default_args": {
      "tipContent": "hello",
      "duration": 3000,
      "icon": "success"
    }
  },
  {
    "name": "hideToast",
    "default_args": {}
  },
  {
    "name": "hiddenHudToast",
    "default_args": {}
  },
  {
    "name": "showLoading",
    "default_args": {
      "tipContent": "加载提示"
    }
  },
  {
    "name": "hideLoading",
    "default_args": {}
  },
  {
    "name": "showModal",
    "default_args": {
      "tipTitle": "弹窗标题",
      "tipContent": "弹窗内容",
      "showCancel": true
    }
  },
  {
    "name": "showActionSheet",
    "default_args": {
      "title": "hello",
      "itemList": [
        "hello",
        "world",
        "he"
      ],
      "content": "content",
      "__event__": null
    }
  },
  {
    "name": "showPickerView",
    "default_args": {
      "rowHeight": "44",
      "pickerHeight": "450",
      "leftText": "取消",
      "leftTextColor": "#3A6BEC",
      "leftTextSize": 20,
      "rightText": "确定",
      "rightTextSize": 20,
      "rightTextColor": "#3A6BEC",
      "backgroundColor": "#1E1F20",
      "backgroundColorAlpha": "0.7",
      "pickerBackgroundColor": "#f7f7f7",
      "toolBarBackgroundColor": "#f5f5f5",
      "data": [
        [
          "北京A",
          "北京B",
          "北京C",
          "北京D",
          "北京E",
          "北京F"
        ],
        [
          "1街A",
          "1街B",
          "1街C",
          "1街D",
          "1街E",
          "1街F"
        ],
        [
          "2街A",
          "2街B",
          "2街C",
          "2街D",
          "2街E",
          "2街F"
        ],
        [
          "3街A",
          "3街B",
          "3街C",
          "3街D",
          "3街E",
          "3街F"
        ]
      ]
    }
  },
  {
    "name": "hideTabbar",
    "default_args": {}
  },
  {
    "name": "showTabbar",
    "default_args": {}
  }
]
)}}

export default osCheck();
