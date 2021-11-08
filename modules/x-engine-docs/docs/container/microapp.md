microapp 也就是本地 h5 拥有原生 api 的能力.



###  增加 microapp.json, sitemap.json, router.json

microapp.json： 微应用，在线应用配置信息。

sitemap.json:   应用自身文件描述信息。

router.json:    路由映射信息。

zip 包名将不再拥有任何意义. 以 microapp.json 里的 id 与 version 为准.  *如果不存在这两文件,将视为无效的 microapp.*



添加 microapp.json 到 打包路径. 

``` json
{
  "id":"com.gm.microapp.home",
  "version":0,
}
```

version: 从 0 开始编号, 新版本+1 即可. 



添加 sitemap.json 到 打包路径. 

sitemap.json 描述了 microapp 包里所有的文件. 供预缓存用.

打包出来的 js 必须根据文件内容带上 hash值.

``` json
[
"static/images/bc4e21b7c0d57ac38d380ddb3b443699.png",
"static/images/91939ecd8864f8f9aa7930c8a2bdd8af.png",
"js/abcdfnsd31.js",
"js/12312jsdksi.js",
"js/a1231231231.js",
"js/chunk-vendors-sdfdsfnsdfkj.js",
"index.html",
"microapp.json",
"sitemap.json",
"favicon.ico"
]

```



路径示意, 与 index.html 平级:

xxxxx.zip

- js/
- microapp.json
- sitemap.json
- index.html
- ...