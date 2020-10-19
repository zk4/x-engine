import xengine from "@zk4/xengine";
import network from "@zk4/network";
//import searchIcon from './assets/search.png';
//import cssFile from './index.css'

xengine.server = xengine.server || {};

xengine.server.startServer = function (args) {
  /*
   * Promise
   * resolve : 给业务人员返回成功
   * reject  : 给业务人员返回的失败
   */
  return new Promise(function (resolve, reject) {
    try {
      /*
       *  调用dsBridge.call(namespace, args, functionCallBackq){}
       *  参数1: 命名空间+和移动端定义的方法名
       *  参数2: 传给移动端的参数 通过JSON.stringify(参数)
       *  参数3: 移动端的回调用
       */
      xengine.bridge.call("com.zkty.module.server.startServer", args, function (res) {

        resolve(res)
      })

    } catch (error) {
      reject(error)
    }
  })
}

export default xengine.server;
