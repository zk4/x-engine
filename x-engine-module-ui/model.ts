// 命名空间
const moduleID = "com.zkty.module.ui";

interface XETipDTO{
  tipContent:string;
}

interface XEToastDTO{
  tipContent:string;
  duration:int;
  //success; loading;
  icon:string;
}

interface XEModalDTO{
  tipTitle?:string;
  tipContent:string;
  showCancel:boolean;
}

interface XEPickerDTO{
  // tapIndex:string;
  leftText:string;
  leftTextSize:int;
  leftTextColor:string;

  rightText:string;
  rightTextSize:int;
  rightTextColor:string;

  backgroundColor:string;
  backgroundColorAlpha:string;

  pickerBackgroundColor:string;
  pickerHeight:string;

  rowHeight:string;

  data:string;

  toolBarBackgroundColor:string;
}

interface XEAlertResultDTO{
  tapIndex:string;
}

function showSuccessToast(arg:XETipDTO={tipContent:'成功提示'}) {
  window.showSuccessToast = () => {
    ui
      .showSuccessToast()
      .then((res) => {
      });
  };
}

function showFailToast(arg:XETipDTO={tipContent:'失败提示'}) {
  window.showFailToast = () => {
    ui
      .showFailToast()
      .then((res) => {
      });
  };
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

function showModal(arg:XEModalDTO={tipTitle:'弹窗标题', tipContent:'弹窗内容', showCancel:true}) : XEAlertResultDTO{
  window.showModal = () => {
    ui
      .showModal()
      .then((res) => {
      });
  };
}

function showActionSheet() {
  window.showActionSheet = () => {
    ui
      .showActionSheet()
      .then((res) => {
      });
  };
}

function showPickerView() {
  window.showPickerView = () => {
    ui
      .showPickerView()
      .then((res) => {
      });
  };
}
