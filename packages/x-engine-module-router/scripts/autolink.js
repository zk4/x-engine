#!/usr/bin/env node

const path = require("path");
const npm = require("npm");
const { run } = require("./utils");
const fse = require("fs-extra");

function filterName(data, name) {
  if (!data) return;
  let deps = data["dependencies"];
  if (!deps) return;
  return Object.keys(deps).filter((k) => {
    return k.startsWith(name);
  });
}

function genRB(path, deps) {
  function line(name) {
    return `pod '${name.split("/").pop()}', :path =>'../node_modules/${name}'`;
  }
  let tmplt = `
require "json"
def module_pods
  ${deps.map((m) => line(m)).join("\n  ")}
  
end
  `;
  fse.outputFile(path, tmplt, (err) => {
    if (err) {
      console.log(err);
    } else {
      console.log(`${path}  was saved!`);
    }
  });
}

run("npm ls --dpeth=0 --json", (result) => {
  let jdata = JSON.parse(result);
  let jdata2 = filterName(jdata, "@zkty-team");

  let path = "iOS/ModulePods.rb";
  console.log(jdata2) 
  genRB(path, jdata2);

  run("cd iOS && pod install", (result) => {
    console.log(result);
  });

});

