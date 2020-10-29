const swaggerParserMock = require("swagger-parser-mock");
const fs = require("fs");
const mkdirp = require("mkdirp");
const chalk = require('chalk')
const md5 = require('md5');
const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const Mock = require("mockjs");
const cors = require('cors');
const {config} = require("process");
const storage = require('node-persist');


const Random = Mock.Random;
Random.string = Random.ctitle
app.use(cors())

//app.use((req, res, next) => {
//res.header('Access-Control-Allow-Origin', '*')
//res.header('Access-Control-Allow-Headers', 'Authorization,X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method' )
//res.header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PATCH, PUT, DELETE')
//res.header('Allow', 'GET, POST, PATCH, OPTIONS, PUT, DELETE')
//next();
//});

//body-parser - node.js 中间件，用于处理 JSON, Raw, Text 和 URL 编码的数据。
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

//静态文件
app.use(express.static("public"));
app.use(express.static("public/views")); //login.html在views文件夹中
app.use(express.static("public/json"));
const port = 3000;

const synchronizeSwagger = {
  async init({
    urls,
    blacklist,
    outputPath,
    dataLength,
    fileName,
    whitelist,
    prefix = "/",
  }) {
    await storage.init({
        dir: './cache',
     
        stringify: JSON.stringify,
     
        parse: JSON.parse,
     
        encoding: 'utf8',
     
        logging: true,  // can also be custom logging function
     
        ttl: false, // ttl* [NEW], can be true for 24h default or a number in MILLISECONDS or a valid Javascript Date object
     
        expiredInterval: 3000 * 60 * 1000, // every 3000000 minutes the process will clean-up the expired cache
     
        // in some cases, you (or some other service) might add non-valid storage files to your
        // storage dir, i.e. Google Drive, make this true if you'd like to ignore these files and not throw an error
        forgiveParseErrors: false
     
    });

    for (let entry of urls) {
      const url = entry.url;
      const name = entry.name;
      this.name = name;
      console.log(chalk.green(name+"------------------------"));
      this.blacklist = blacklist;
      this.whitelist = whitelist;
      this.outputPath = outputPath;
      this.dataLength = dataLength;
      this.fileName = fileName;
      this.content = "";
      this.prefix = prefix;
      await this.parse(url);

      //if (this.content) {
      //await writeToMockFile(this.outputPath, this.fileName, this.content)
      //} else {
      //return ({ state: 'failed' })
      //}
      
    }
    app.listen(port, () => {
      console.log(`Example app listening at http://localhost:${port}/times`);
    });
    //console.log(Random.image('200x100'))
    return { state: "success" };
  },
  // 解析swagger-api-doc
  async parse(url) {
    //let key = md5(url)

    //// make sure folder exist
    //mkdirp('./cache', (err) => {
      //throwErr(err);
    //});

    //const exist  = await this.checkFileExist('./cache/'+key);
    //fs.readFile('./cache/'+key,"utf8",  (err,data)=>{
      //if(!err){
        //let paths = JSON.parse(data)
        //this.traverse(paths);
      //}
    //})

    //let paths = await storage.getItem(md5(url));
    //console.log(paths)
    //if ( paths == undefined ){
    let {paths}  = await swaggerParserMock(url);
      //console.log(paths)
      //await storage.setItem( md5(url), paths)
    //}else{
      //console.log("hit cache")
    //}
    this.traverse(paths);
  },
  // 初始化目录 判断是否有该文件
  async checkFileExist(fileName) {
    return new Promise((resolve, reject) => {
      fs.exists(fileName, (exists) => {
        resolve(exists);
      });
    });
  },

  // 遍历paths
  traverse(paths) {
    let index = 0;
    this.content = "";
    for (let path in paths) {
      index++;
      this.traverseMethod(paths, path);
      if (
        this.blacklist.length &&
        !this.blacklist.includes(path.match(/[a-zA-z]+/g)[0])
      ) {
        this.traverseMethod(paths, path);
      }
    }
  },

  // 遍历某模块下的所有方法
  traverseMethod(paths, path) {
    for (let method in paths[path]) {
      const summary = paths[path][method]["summary"];
      const response = paths[path][method]["responses"]["200"];
      this.generate(summary, response["example"], method, path);
    }
  },
  // 生成指定格式的文件后写入到指定文件中
  async generate(summary, example, method, path) {
    try {
      const data = this.generateTemplate({ summary, example, method, path });
      //console.log(data)
      this.content += data;
    } catch (error) {}
  },

  // 生成mock api模版
  generateTemplate({ summary, example, method, path }) {
    // api path中的{petId}形式改为:petId
    const data = formatResToMock(path, example, this.dataLength);
    const urlpath= path.replace(/\{([^}]*)\}/g, ":$1")
    console.log(method.toLowerCase(),`http://localhost:${port}/times/${this.name}${urlpath}`);
    //console.log(this.name+urlpath)
    app[method.toLowerCase()](
      "/times/"+this.name+urlpath,
      (req, res) => {
        let retdata = eval("(" + data.replace(/null/g, "") + ")");
        res.send(Mock.mock(retdata));
      }
    );
    return `
    // ${summary}
    '${method.toLowerCase()} ${this.prefix}${path.replace(
      /\{([^}]*)\}/g,
      ":$1"
    )}': (req, res) => {
      res.send(Mock.mock(${data.replace(/null/g, "") || `true`}));
    },
    `;
  },
};

// 格式化mock，如果是menu直接拿/mock/menu.json,其它如果是数组，自动添加多条数据
function formatResToMock(path, res, dataLength) {
  function f(obj, prop, val){
  if (typeof obj == 'object'){
    if (obj.hasOwnProperty(prop))
      obj[prop] = val;
      
    for (let i in obj)
      f(obj[i], prop, val);
  }
}
  let data = "";

  let praseRes = JSON.parse(res);
  if (Array.isArray(praseRes)) {
    data = `{ 
      "code": 200, 
      "message": 'success' ,
      "data|${dataLength}": ${res}
    }`;
  } else {
    Object.keys(praseRes).forEach((key) => {
      if (Array.isArray(praseRes[key])) {
        praseRes[`${[key]}|${dataLength}`] = praseRes[key];
        delete praseRes[key];
      }else{
        //console.log(key)
      }
    });
    //console.log(Random.image('200x100'))

    f(praseRes, 'userImage', Random.image('100x100'));
    f(praseRes, 'icon', Random.image('100x100'));
    f(praseRes, 'advertPicture', Random.image('320x180'));
    f(praseRes, 'message', Random.cparagraph());
    f(praseRes, 'roomName', Random.string());
    f(praseRes, 'appCode', 'com.zkty.microapp.nav');
    f(praseRes, 'uri', '/index.html');
    // does not work
    f(praseRes, 'isDeleted', Random.boolean(false,true));
    data =JSON.stringify({...praseRes,code:200}) ;
  }

  return data;
}

// 将mock数据写入js文件
//function writeToMockFile(outputPath, fileName, content) {
//// 写入文件
//let temp = `var Mock = require('mockjs')
//export default {
//${content}
//}
//`
//fs.writeFile(`${outputPath}/${fileName}`, temp, err => throwErr)
//}

// 初始模版
//function initTemp(path, fileName) {
//fs.writeFile(`${path}/${fileName}`, '', err => throwErr(err))
//}
function throwErr(err) {
  if (err) {
    console.error("同步失败", err);
    throw err;
  }
}

module.exports = {
  synchronizeSwagger,
};
