
const fs = require('fs');
const promisify = require('util').promisify;
const stat = promisify(fs.stat);//stat方法promise化
const readdir = promisify(fs.readdir);
const config = require('../config/defaultConfig.js');
module.exports = async function(req, res, filePath){
    try{
        const stats = await stat(filePath);//awit必须包含在async函数中,所以把所有代码移到定义的readFile函数中
        if(stats.isFile()){//如果是文件
            res.statusCode = 200;
            res.setHeader('Content-Type','text/javascript;charset=UTF-8');
            fs.createReadStream(filePath).pipe(res);//以流的方式来读取文件
        }else if (stats.isDirectory()) {//如果是文件夹，拿到文件列表
            //将readdir方法也promise化
            const files = await readdir(filePath);
                res.statusCode = 200;
                res.setHeader('Content-Type','text/html;charset=UTF-8');
                res.write('<html><body><div>')
                var html= '';
                for(let i=0;i<files.length;i++){//
                    html+='<a style="display:block" href="http://127.0.0.1:9527'+ 
                            req.url+'/'+files[i]+'">'+files[i]+'</a>';
                }
                res.write(html);//返回所有的文件名
                res.end('</div></body></html>')
        }
    }catch(err){
        console.log(err)
        res.statusCode = 404;
        res.setHeader('Content-Type','text/javascript;charset=UTF-8');//utf8编码，防止中文乱码
        res.end(`${filePath} is not a directory or file.`)
        return;
    }
}