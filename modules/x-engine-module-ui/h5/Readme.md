
version: 0.1.12
``` bash
npm install @zkty-team/x-engine-module-ui
```



## showToast



**demo**
``` js
 {
  window.showToast = () => {
    ui
      .showToast()
      .then((res) => {
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| tipContent | string | 必填 | hello | toast文字内容 |
| duration | int | 必填 | 3000 | toast时间间隔 |
| icon | string | 必填 | success | success; loading;
toast图片地址 |
参数 object  定义
``` js


interface XEToastDTO{

  //toast文字内容
  tipContent:string;
  //toast时间间隔
  duration:int;
  //success; loading;
  //toast图片地址
  icon:string;

}
``` 


---------------------
**无返回值**




## hideToast



**demo**
``` js
 {
  window.hideToast = () => {
    ui
      .hideToast()
      .then((res) => {
      });
  };
}
``` 

	
**无参数**


参数 object  定义


---------------------
**无返回值**




## hiddenHudToast



**demo**
``` js
 {
  window.hiddenHudToast = () => {
    ui
      .hiddenHudToast()
      .then((res) => {
      });
  };
}
``` 

	
**无参数**


参数 object  定义


---------------------
**无返回值**




## showLoading



**demo**
``` js
 {
  window.showLoading = () => {
    ui
      .showLoading()
      .then((res) => {
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| tipContent | string | 必填 | 加载提示 | loading文字内容 |
参数 object  定义
``` js


interface XETipDTO{

  //loading文字内容
  tipContent:string;

}
``` 


---------------------
**无返回值**




## hideLoading



**demo**
``` js
 {
  window.hideLoading = () => {
    ui
      .hideLoading()
      .then((res) => {
      });
  };
}
``` 

	
**无参数**


参数 object  定义


---------------------
**无返回值**




## showModal



**demo**
``` js
{
  window.showModal = () => {
    ui
      .showModal()
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| tipTitle | string | optional | 弹窗标题 | modal标题 |
| tipContent | string | 必填 | 弹窗内容 | modal文字内容 |
| showCancel | bool | 必填 | true | modal是否显示取消按钮 |
参数 object  定义
``` js


interface XEModalDTO{

  //modal标题
  tipTitle?:string;
  //modal文字内容
  tipContent:string;
  //modal是否显示取消按钮
  showCancel:boolean;

}
``` 


---------------------
**返回值**
``` js


interface XERetDTO {

  //返回值
  content: string;

}
``` 




## showActionSheet



**demo**
``` js
{
  window.showActionSheet = (...args) => {
    ui
      .showActionSheet({
        title: "hello",
        itemList: ["hello", "world", "he"],
        content: "content",
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string | 必填 | hello |  标题 |
| itemList | Array\<string\> | optional | ["hello","world","he"] |  子标题? |
| content | string | optional | content |  内容 |
| \_\_event\_\_ | _1_com.zkty.module.ui_DTO | 必填 |  |  点击子标题回调函数 |
参数 object  定义
``` js


interface XESheetDTO {

  // 标题
  title: string;
  // 子标题?
  itemList?: Array<string>;
  // 内容
  content?: string;
  // 点击子标题回调函数
  __event__: (index:string)=>void,


}
``` 


---------------------
**返回值**
``` js


interface XERetDTO {

  //返回值
  content: string;

}
``` 




## showPickerView



**demo**
``` js
{
  window.showPickerView = (...args) => {
    ui
      .showPickerView({
        __event__: (res) => {
          document.getElementById("debug_text").innerText = res;
        },
      })
      .then((res) => {

        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}
``` 

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| leftText | string | 必填 | 取消 |  tapIndex:string;
左按钮文字 |
| leftTextSize | int | 必填 | 20 | 左按钮文字字体大小 |
| leftTextColor | string | 必填 | #3A6BEC | 左按钮文字字体颜色 |
| rightText | string | 必填 | 确定 | 右按钮文字 |
| rightTextSize | int | 必填 | 20 | 右按钮文字字体大小 |
| rightTextColor | string | 必填 | #3A6BEC | 右按钮文字字体颜色 |
| backgroundColor | string | 必填 | #1E1F20 | pikerView整体背景颜色 |
| backgroundColorAlpha | string | 必填 | 0.7 | pikerView背景颜色透明度 |
| pickerBackgroundColor | string | 必填 | #f7f7f7 | pikerView区域背景颜色  |
| pickerHeight | string | 必填 | 450 | pikerView高度 |
| rowHeight | string | 必填 | 44 | 行高 |
| data | Array\<Array\<string\>\> | 必填 | [["北京A","北京B","北京C","北京D","北京E","北京F"],["1街A","1街B","1街C","1街D","1街E","1街F"],["2街A","2街B","2街C","2街D","2街E","2街F"],["3街A","3街B","3街C","3街D","3街E","3街F"]] | 数据 |
| toolBarBackgroundColor | string | 必填 | #f5f5f5 | 工具栏颜色 |
| \_\_event\_\_ | _0_com.zkty.module.ui_DTO | 必填 | (string)=>{} | 点击确定回调函数 |
参数 object  定义
``` js


interface XEPickerDTO{

  // tapIndex:string;
  //左按钮文字
  leftText:string;
  //左按钮文字字体大小
  leftTextSize:int;
  //左按钮文字字体颜色
  leftTextColor:string;

  //右按钮文字
  rightText:string;
  //右按钮文字字体大小
  rightTextSize:int;
  //右按钮文字字体颜色
  rightTextColor:string;

  //pikerView整体背景颜色
  backgroundColor:string;
  //pikerView背景颜色透明度
  backgroundColorAlpha:string;
  //pikerView区域背景颜色 
  pickerBackgroundColor:string;
  //pikerView高度
  pickerHeight:string;

  //行高
  rowHeight:string;

  //数据
  data:Array<Array<string>>;

  //工具栏颜色
  toolBarBackgroundColor:string;

  //点击确定回调函数
  __event__:(string)=>void;

}
``` 


---------------------
**返回值**
``` js


interface XERetDTO {

  //返回值
  content: string;

}
``` 




## hideTabbar



**demo**
``` js
 {
  window.hideTabbar = () => {
    ui
      .hideTabbar()
      .then((res) => {
      });
  };
}
``` 

	
**无参数**


参数 object  定义


---------------------
**无返回值**




## showTabbar



**demo**
``` js
 {
  window.showTabbar = () => {
    ui
      .showTabbar()
      .then((res) => {
      });
  };
}
``` 

	
**无参数**


参数 object  定义


---------------------
**无返回值**



    