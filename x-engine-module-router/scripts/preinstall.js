#!/usr/bin/env node

const { exec } = require("child_process");
const pjson = require('../package.json');
console.log("preinstall ...")

const name = pjson.name;
const version = pjson.version;


function run(cmd) {
  exec(cmd, (error, stdout, stderr) => {
    if (error) {
      console.log(`error: ${error.message}`);
      return;
    }
    if (stderr) {
      console.log(`stderr: ${stderr}`);
      return;
    }
    console.log(`stdout: ${stdout}`);
  });
}

run(`podspec-bump -i ${version} -w`)

	

