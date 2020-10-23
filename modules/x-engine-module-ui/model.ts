// 命名空间
const moduleID = "com.zkty.module.ui";

interface XETipDTO{
  //loading文字内容
  tipContent:string;
}

interface XEToastDTO{
  //toast文字内容
  tipContent:string;
  //toast时间间隔
  duration:int;
  //success; loading;
  //toast图片地址
  icon:string;
}

interface XEModalDTO{
  //modal标题
  tipTitle?:string;
  //modal文字内容
  tipContent:string;
  //modal是否显示取消按钮
  showCancel:boolean;
}

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

interface XERetDTO {
  //返回值
  content: string;
}

function showToast(arg:XEToastDTO={
  tipContent:"hello",
  duration:3000,
  icon:"success"
}) {
  window.showToast = () => {
    ui
      .showToast()
      .then((res) => {
      });
  };
}

function hideToast() {
  window.hideToast = () => {
    ui
      .hideToast()
      .then((res) => {
      });
  };
}

function hiddenHudToast() {
  window.hiddenHudToast = () => {
    ui
      .hiddenHudToast()
      .then((res) => {
      });
  };
}

function showLoading(arg:XETipDTO={tipContent:'加载提示'}) {
  window.showLoading = () => {
    ui
      .showLoading()
      .then((res) => {
      });
  };
}

function hideLoading() {
  window.hideLoading = () => {
    ui
      .hideLoading()
      .then((res) => {
      });
  };
}

function showModal(arg:XEModalDTO={tipTitle:'弹窗标题', tipContent:'弹窗内容', showCancel:true}) : XERetDTO{
  window.showModal = () => {
    ui
      .showModal()
      .then((res) => {
        document.getElementById("debug_text").innerText = JSON.stringify(res);
      });
  };
}

function showActionSheet(
  XESheetDTO: XESheetDTO = {
    title: "hello",
    itemList: ["hello", "world", "he"],
    content: "content",
    __event__: null,
  }
):XERetDTO{
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

function showPickerView(
  XEPickerDTO: XEPickerDTO = {
    rowHeight:'44',
    pickerHeight: '450',
    leftText:"取消",
    leftTextColor: "#3A6BEC",
    leftTextSize: 20,
    rightText:"确定",
    rightTextSize: 20,
    rightTextColor: "#3A6BEC",
    backgroundColor: "#1E1F20",
    backgroundColorAlpha: '0.7',
    pickerBackgroundColor: "#f7f7f7",
    toolBarBackgroundColor:"#f5f5f5",
    data: [
            ["北京A", "北京B", "北京C","北京D", "北京E", "北京F"],
            ["1街A", "1街B", "1街C","1街D", "1街E", "1街F"],
            ["2街A", "2街B", "2街C","2街D", "2街E", "2街F"],
            ["3街A", "3街B", "3街C","3街D", "3街E", "3街F"],
          ],
      __event__:(string)=>{},
  }
):XERetDTO{
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

