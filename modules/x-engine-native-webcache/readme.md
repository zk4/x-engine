我们只需要拦截 js, css , 不拦截 html. 图片, api 请求.





``` mermaid
graph TD
A[请求] -->|Get money| B(拦截)
B --> C{是否有缓存}
C -->|有| D[直接读缓存] 
C -->|没有| E[请求网络] --> 网络模块
```





## 参考

[**网易云音乐大前端团队** WKWebView 请求拦截探索与实践](https://juejin.cn/post/6922625242796032007 )

[WKURLSchemeHandler 的能与不能](https://www.jianshu.com/p/6bae04c91297)