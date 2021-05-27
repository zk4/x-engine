#!/usr/bin/env node

const path = require('path')
function resolveDeps(deps){
  for (let  key  in  deps) {
    let mname = key;
    let version = resolveDep(mname,deps[key]);
    deps[key]= version;
  }
}

function resolveDep(name,version_set){
  if(version_set.size>1){
    console.log(`${name} 版本有冲突:${[...version_set]} 你可能需要解决。`)
  }
  for(v in version_set){
    console.log(v)
  }
  return [...version_set].pop()
}
function readDeps(packagejsonDir){
  let finalDeps   = {}
  let packagejson = require(packagejsonDir+"/package.json")
  let deps        = packagejson["dependencies"]

  for (let  key  in deps ) {
    let mname      = key;
    let version    = deps[key];
    let modulename = mname.split("/").pop()

    if(modulename.startsWith("x-engine-module-"))
    {
      if(!finalDeps[key]){
        finalDeps[key]=new Set()
      }
      finalDeps[key].add(version)
      readDeps(packagejsonDir+'/node_modules/'+mname)
    }
  }
  return finalDeps;
}

let finalDeps = readDeps('..')
resolveDeps(finalDeps)
console.log(finalDeps)


