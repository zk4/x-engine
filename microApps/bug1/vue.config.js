const path = require('path')
const webpack = require('webpack')
const buildDate = JSON.stringify(new Date().toLocaleString())
// const createThemeColorReplacerPlugin = require('./config/plugin.config')
// const CompressionWebpackPlugin = require("compression-webpack-plugin"); // 开启gzip压缩， 按需引用
// const productionGzipExtensions = /\.(js|css|json|txt|html|ico|svg)(\?.*)?$/i; // 开启gzip压缩， 按需写入


function resolve (dir) {
  return path.join(__dirname, dir)
}


const isProd = process.env.NODE_ENV === 'production'

const assetsCDN = {
  // webpack build externals
  externals: {
    vue: 'Vue',
    'vue-router': 'VueRouter',
    'Antd': 'ant-design-vue',
    vuex: 'Vuex',
    axios: 'axios'
  },
  css: [],
  // https://unpkg.com/browse/vue@2.6.10/
  js: [
    '//cdn.jsdelivr.net/npm/vue@2.6.10/dist/vue.min.js',
    '//cdn.jsdelivr.net/npm/vue-router@3.1.3/dist/vue-router.min.js',
    '//cdn.jsdelivr.net/npm/vuex@3.1.1/dist/vuex.min.js',
    '//cdn.jsdelivr.net/npm/axios@0.19.0/dist/axios.min.js'
  ]
}

// vue.config.js
const vueConfig = {
    // 默认'/'，部署应用包时的基本 URL
  // publicPath: process.env.NODE_ENV === 'production' ? '/' : './',
  publicPath:'./',
  // configureWebpack: {
  //   // webpack plugins
  //   plugins: [
  //     // Ignore all locale files of moment.js
  //     new webpack.IgnorePlugin(/^\.\/locale$/, /moment$/),
  //     new webpack.DefinePlugin({
  //       APP_VERSION: `"${require('./package.json').version}"`,
  //       BUILD_DATE: buildDate
  //     }),
  //     new CompressionWebpackPlugin({
  //       filename: "[path].gz[query]",
  //       algorithm: "gzip",
  //       test: productionGzipExtensions,
  //       threshold: 100,
  //       minRatio: 0.8
  //     })
  //   ],
  //   // if prod, add externals
  //   // externals: isProd ? assetsCDN.externals : {}
  // },

  chainWebpack: (config) => {
    // 移除prefetch插件，避免加载多余的资源
    config.plugins.delete('prefetch')
    // 压缩图片
    const imagesRule = config.module.rule('images')
    imagesRule.uses.clear()
    imagesRule.use('file-loader')
      .loader('url-loader')
      .options({
        limit: 10240,
        fallback: {
          loader: 'file-loader',
          options: {
            outputPath: 'static/images'
          }
        }
      })

    // 压缩响应的app.json返回的代码压缩
    config.optimization.minimize(true)

    config.resolve.alias
      .set('@$', resolve('src'))
      .set('assets', resolve('src/assets'))

    const svgRule = config.module.rule('svg')
    svgRule.uses.clear()
    svgRule
      .oneOf('inline')
      .resourceQuery(/inline/)
      .use('vue-svg-icon-loader')
      .loader('vue-svg-icon-loader')
      .end()
      .end()
      .oneOf('external')
      .use('file-loader')
      .loader('file-loader')
      .options({
        name: 'assets/[name].[hash:8].[ext]'
      })

    // if prod is on
    // assets require on cdn
    // if (isProd) {
    //   config.plugin('html').tap(args => {
    //     args[0].cdn = assetsCDN
    //     return args
    //   })
    // }
  },

  css: {
    loaderOptions: {
      less: {
        lessOptions: {
          modifyVars: {
            'primary-color': '#4B7AFB',
            'layout-trigger-background': '#3A3F48',
            'menu-dark-submenu-bg': '#303e51',
            'layout-header-background': '#414751',
            'link-color': '#4B7AFB',
            'border-radius-base': '2px',
          },
          javascriptEnabled: true,
        },
      },
    },
  },

  devServer: {
    // development server port 8080
    port: 8080,
    // If you want to turn on the proxy, please remove the mockjs /src/main.jsL11
    proxy: {
      "/picture/": {
        target: "https://times-dev-user-center.oss-cn-beijing.aliyuncs.com",
        changeOrigin: true,
      },
      "/times/": {
        target: "http://dev.linli590.cn:16666", //后端ip地址及端口
        ws: true, //是否跨域
        changeOrigin: true,
      },
    }
  },

  // disable source map in production
  productionSourceMap: false,
  lintOnSave: undefined,
  // babel-loader no-ignore node_modules/*
  transpileDependencies: []
}

// preview.pro.loacg.com only do not use in your production;
if (process.env.VUE_APP_PREVIEW === 'true') {
  console.log('VUE_APP_PREVIEW', true)
  // add `ThemeColorReplacer` plugin to webpack plugins
  // vueConfig.configureWebpack.plugins.push(createThemeColorReplacerPlugin())
}

module.exports = vueConfig
