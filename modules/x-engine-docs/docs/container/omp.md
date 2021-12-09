omp 容器为  online microapp 的缩写. 也就是 h5 拥有本地 api 的功能.  
路由以 omp: omps: microapp: 开头



android 使用的 x5 浏览器。

iOS 使用的 wkwebview。

## 一些JS在平台之间要注意差异

### new Date 差异

```
new Date('2017-07-13 20:01:02')
```

这条命令在 Chrome， X5 控制台中运行，结果如下：

```
Thu Jul 13 2017 20:01:02 GMT+0800 (China Standard Time)
```



而在Safari，Wkwebview 中，结果却是这样：
```
Invalid Date
```



原来Safari不支持直接将这种格式的字符串转为Date对象，所以接下来的处理就都出错了。

解决方案为：
引入moment库，然后进行格式转换，例如：

```
moment('2017-07-13 20:01:02', 'YYYY-MM-DD HH:mm:ss').format('YYYYMMDDHHmmss')
```



