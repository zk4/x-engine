// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


import xengine from "@zkty-team/x-engine-module-engine";
import mock from "./mock";
function osCheck() {
  if (false) {
    return mock;
} 
  else {

    return  xengine.use("com.zkty.module.share", 
    [
  {
    "name": "share",
    "default_args": {
      "type": "link"
    }
  },
  {
    "name": "shareForOpenWXMiniProgram",
    "default_args": {}
  }
]
)}}

export default osCheck();
