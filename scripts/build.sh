###
 # @Author: sheng.wang
 # @Date: 2021-05-31 19:26:34
 # @LastEditTime: 2021-05-31 19:26:36
 # @LastEditors: sheng.wang
 # @Description: 
 # @FilePath: /x-engine/scripts/build.sh
### 
cd ./npm-modules/x-engine-vue/x-engine-vuex
npm run build
cd ../x-engine-vue-custom-router
npm run build
cd ../x-engine-ui
npm run lib
cd ../x-engine-lifecycle
npm run build
cd ....