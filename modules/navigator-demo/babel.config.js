module.exports = {
  presets: [
    '@vue/cli-plugin-babel/preset'
  ],
  // 对于使用 babel7 的用户，可以在 babel.config.js 中配置
  plugins: [
    ['import', {
      libraryName: 'vant',
      libraryDirectory: 'es',
      style: true
    }, 'vant']
  ]
}
