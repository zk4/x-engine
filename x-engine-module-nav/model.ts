// 命名空间
const moduleID = "com.zkty.module.nav";


interface NavTitleDTO {
  //导航条的文字
  title: string;
  //16进制的颜色色值
  titleColor: string;
  //字体大小
  titleSize: int;
}

interface NavPopItem {
  icon?:string;
  iconSize?:string;
  title:string;
  __event__?:string;
}

interface NavBtnDTO {
  //导航条右边按钮的文字
  title: string;
  //16进制的颜色色值
  titleColor: string;
  //导航条文字的大小
  titleSize: int;
  //见下方说明
  icon?: string;
  //图片的宽高
  iconSize: Array<number>;

  popList?: Array<Map<string,string>>;
  //见下方说明
  showMenuImg?: string;
  //menu的宽
  popWidth?: string;

  __event__?: string;
}

interface NavMoreBtnDTO {

  btns: Array<NavBtnDTO>;
}

interface NavNavigatorDTO {
  //跳转地址
  url?: string;
  //其余参数
  params?: string;
}

interface NavOpenAppDTO {
  //跳转类型
  type: string;
  //跳转目标
  uri: string;
  //跳转参数
  path: string;
}

interface NavSearchBarDTO {
  //搜索框圆角大小
  cornerRadius: int;
  //搜索框背景颜色
  backgroundColor: string;
  //搜索框里搜索图片
  iconSearch: string;
  //搜索框里搜索图片大小
  iconSearchSize: Array<number>;
  //搜索框里清空图片
  iconClear: string;
  //搜索框里清空图片大小
  iconClearSize: Array<number>;
  //搜索框文本颜色
  textColor: string;
  //搜索框文本字体大小
  fontSize: int;
  //搜索框占位符
  placeHolder: string;
  //搜索框占位符大小
  placeHolderFontSize: int;
  //搜索框是否添加点击事件
  isInput: boolean;
  //搜索框是否获取焦点
  becomeFirstResponder: boolean;

  __event__?: string;
}

function setNavTitle(arg: NavTitleDTO = { title: "title", titleColor: "#000000", titleSize: 16 }) {
  window.setNavTitle = () => {
    nav
      .setNavTitle()
      .then((res) => { });
  };
}




function setNavLeftBtn(arg: NavBtnDTO = { title: "left", titleColor: "#000000", titleSize: 16, icon: "", iconSize: ["20", "20"] }) {

  window.setNavLeftBtn = () => {
    nav
      .setNavLeftBtn()
      .then((res) => { });
  };
}

function setNavRightBtn(arg: NavBtnDTO = { title: "right", titleColor: "#000000", titleSize: 16, icon: "", iconSize: ["20", "20"] }) {
  window.setNavRightBtn = () => {
    nav
      .setNavRightBtn({ title: "right", titleColor: "#000000", titleSize: 16, icon: "", iconSize: ["20", "20"], __event__:()=>{
        document.getElementById("debug_text").innerText = "ret: click right";
      }})
      .then((res) => { });
  };
}
  
function setNavRightMenuBtn(arg:NavBtnDTO = { title: "menu", titleColor: "#000000", titleSize: 16, icon: "", iconSize: ["20", "20"], popWidth:"200", showMenuImg:"false", popList:[{"icon":"","iconSize":"20","title":"1"}, {"icon":"","iconSize":"20","title":"2"}, {"icon":"","iconSize":"20","title":"3"}]}) {
  // var map = { title: "menu", titleColor: "#000000", titleSize: 16, icon: "", iconSize: ["20", "20"], popWidth:"200", showMenuImg:"false", popList:[]}
  // var i;
  // for(i = 0; i < 3; i++){

  //   map["popList"].push({"icon":"","iconSize":"20","title":i, __event__:(r)=>{
  //     document.getElementById("debug_text").innerText = "ret: click setNavRightMenuBtn: " + r;
  //   }})
  // }
  
  window.setNavRightMenuBtn = () => {
    nav
      .setNavRightMenuBtn({ title: "menu", titleColor: "#000000", titleSize: 16, icon: "", iconSize: ["20", "20"], popWidth:"200", showMenuImg:"false", popList:[{"icon":"","iconSize":"20","title":"1"}, {"icon":"","iconSize":"20","title":"2"}, {"icon":"","iconSize":"20","title":"3"}], __event__:(r)=>{
        document.getElementById("debug_text").innerText = "ret: click setNavRightMenuBtn: " + r
      }})
      .then((res) => { });
  };
}



function setNavRightMoreBtn(arg: NavMoreBtnDTO = { btns: [{ title: "right1", titleColor: "#000000", titleSize: 16, iconSize: ["20", "20"] }, { title: "", icon:"/assets/search.png", titleColor: "#000000", titleSize: 16, iconSize: ["20", "20"] }] }) {
  window.setNavRightMoreBtn = () => {
    nav
      .setNavRightMoreBtn()
      .then((res) => { });
  };
}


//跳转页面.
function navigatorPush(arg: NavNavigatorDTO = { url: "" }) {
  window.navigatorPush = () => {
    nav
      .navigatorPush()
      .then((res) => { });
  };
}
//返回层级. 如果url为空则返回上一级, 堆栈中有对应地址, 则返回该界面
function navigatorBack(arg: NavNavigatorDTO = { url: "" }) {
  window.navigatorBack = () => {
    nav
      .navigatorBack()
      .then((res) => { });
  };
}

//跳转页面.
function navigatorRouter(arg: NavOpenAppDTO = { appid: "" }) {
  window.navigatorRouter = () => {
    nav
      .navigatorRouter()
      .then((res) => { });
  };
}


function setNavSearchBar(arg: NavSearchBarDTO = { cornerRadius: 5, backgroundColor: "#FF0000", iconSearch: "", iconSearchSize: [20, 20], iconClear: "", iconClearSize: [20, 20], textColor: "#000000", fontSize: 16, placeHolder: "默认文字", placeHolderFontSize: 16, isInput: true, becomeFirstResponder: false }) {
  window.setNavSearchBar = () => {
    nav
      .setNavSearchBar({ cornerRadius: 5, backgroundColor: "#FF0000", iconSearch: "", iconSearchSize: [20, 20], iconClear: "", iconClearSize: [20, 20], textColor: "#000000", fontSize: 16, placeHolder: "默认文字", placeHolderFontSize: 16, isInput: true, becomeFirstResponder: false , __event__:()=>{
        document.getElementById("debug_text").innerText = "ret: click searchBar"
      }})
      .then((res) => { });
  };
}
