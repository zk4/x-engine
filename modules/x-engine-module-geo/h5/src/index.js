// DO NOT MODIFY!.
// generated by x-cli, it will be overwrite eventually!


import xengine from "@zkty-team/x-engine-module-engine";
import mock from "./mock";
function osCheck() {
  if (false) {
    return mock;
} 
  else {

    return  xengine.use("com.zkty.module.geo", 
    [
  {
    "name": "coordinate",
    "default_args": {
      "title": "wgs84"
    }
  },
  {
    "name": "locate",
    "default_args": {}
  },
  {
    "name": "locate__event__",
    "default_args": null
  }
]
)}}

export default osCheck();
