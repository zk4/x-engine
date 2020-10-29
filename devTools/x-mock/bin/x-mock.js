#!/usr/bin/env node
'use strict'
const program = require('commander');
const { join } = require('path')
const chalk = require('chalk')

const path = process.cwd()
const config = join(path, 'swagger.config.js')
const data = require(config)
const { synchronizeSwagger } = require('../command/synchronizeSwagger.js')
const log = console.log

program
  .action(function (env, option) {
    log(chalk.yellow('读取配置中...'))
    synchronizeSwagger.init(data).then((item) => {
      log(chalk.yellow('0%'))
      if (item.state === 'success') {
        log(chalk.green('100%'))
        log(chalk.green('生成mock成功！'))
      }
    }).catch(err => {
      log(chalk.red('生成mock失败！'))
      console.log(err)
    })
    })

program.parse(process.argv);
