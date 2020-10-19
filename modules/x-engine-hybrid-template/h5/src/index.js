import ui from "@zk4/ui";
//import cssFile from './index.css'

xengine.ui.showActionSheet = function (args) {
  return new Promise(function (resolve, reject) {
  try {
      xengine.bridge.call("com.zkty.ui.showActionSheet",args, function (res) {
        resolve(res)
      })
    } catch (error) {
      reject(error)
    }
  })
}

export default {};
