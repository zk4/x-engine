// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


import xengine from "@zkty-team/x-engine-module-engine";
import mock from "./mock";
function osCheck() {
  if (!xengine.hybrid) {
    return mock;
} 
  else {

    return  xengine.use("com.zkty.module.secrect", 
    [
  {
    "name": "get",
    "default_args": null
  }
]
)}}

export default osCheck();