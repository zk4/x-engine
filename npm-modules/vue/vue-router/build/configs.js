/*
 * @Author: sheng.wang
 * @Date: 2021-02-09 16:48:14
 * @LastEditTime: 2021-05-25 17:43:02
 * @LastEditors: sheng.wang
 * @Description:
 * @FilePath: /vue-router/build/configs.js
 */
const path = require('path')
const buble = require('rollup-plugin-buble')
const flow = require('rollup-plugin-flow-no-whitespace')
const cjs = require('@rollup/plugin-commonjs')
const node = require('@rollup/plugin-node-resolve').nodeResolve
const replace = require('rollup-plugin-replace')
const version = process.env.VERSION || require('../package.json').version
const banner =
  `/*!
  * vue-router v${version}
  * (c) ${new Date().getFullYear()} Capricorn
  * @license MIT
  */`

const resolve = _path => path.resolve(__dirname, '../', _path)

module.exports = [
  {
    file: resolve('dist/vue-router.js'),
    format: 'umd',
    env: 'development'
  },
  {
    file: resolve('dist/vue-router.min.js'),
    format: 'umd',
    env: 'production'
  },
  {
    file: resolve('dist/vue-router.common.js'),
    format: 'cjs'
  },
  {
    file: resolve('dist/vue-router.esm.js'),
    format: 'es'
  },
  {
    file: resolve('dist/vue-router.esm.browser.js'),
    format: 'es',
    env: 'development',
    transpile: false
  },
  {
    file: resolve('dist/vue-router.esm.browser.min.js'),
    format: 'es',
    env: 'production',
    transpile: false
  }
].map(genConfig)

function genConfig (opts) {
  const config = {
    input: {
      input: resolve('src/index.js'),
      plugins: [
        flow(),
        node(),
        cjs(),
        replace({
          __VERSION__: version
        })
      ]
    },
    output: {
      file: opts.file,
      format: opts.format,
      banner,
      name: 'VueRouter'
    },
    external: ['@zkty-team/x-engine-core']
  }

  if (opts.env) {
    config.input.plugins.unshift(replace({
      'process.env.NODE_ENV': JSON.stringify(opts.env)
    }))
  }

  if (opts.transpile !== false) {
    config.input.plugins.push(buble())
  }

  return config
}
