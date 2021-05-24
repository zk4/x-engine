/*
 * @Author: sheng.wang
 * @Date: 2021-04-28 14:34:33
 * @LastEditTime: 2021-05-24 19:09:58
 * @LastEditors: sheng.wang
 * @Description: 
 * @FilePath: /x-engine/npm-modules/x-engine-ui/vue.config.js
 */
module.exports = {
  devServer: {
    overlay: {
      warnings: false, // 不显示警告
      errors: false	   // 不显示错误
    }
  },
  lintOnSave: false, // 关闭eslint检查
  chainWebpack: config => {
    config.externals({
      '@zkty-team/x-engine-core': '@zkty-team/x-engine-core'
    });
  }
}