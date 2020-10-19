import xengine from "@zk4/xengine";
//import searchIcon from './assets/search.png';
//import cssFile from './index.css'
xengine.model = xengine.model || {};
const _model = window.xengine.module("com.zkty.module.model");
xengine.model  =  {
    ...xengine.model,
    showActionSheet: (args)=>{return _model("showActionSheet",args)},
}



export default xengine.model;
