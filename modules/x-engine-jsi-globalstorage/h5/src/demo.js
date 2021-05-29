
import globalstorage from './index.js'
import xengine from "@zkty-team/x-engine-core";

window.test_set = () => {
{
  xengine.api("com.zkty.jsi.globalstorage", "set",{
    key:'abc',
    val:'world'
  });
}}
 document.getElementById("test_set").click()
      window.test_get = () => {
{
  let val = xengine.api("com.zkty.jsi.globalstorage", "get",
    'abc',
  );
  document.getElementById("debug_text").innerText = val;
}}
 document.getElementById("test_get").click()
      window.test_del = () => {
{
  let val = xengine.api("com.zkty.jsi.globalstorage", "del",
    'abc',
  );
  document.getElementById("debug_text").innerText = val;
}}
 document.getElementById("test_del").click()
      
    