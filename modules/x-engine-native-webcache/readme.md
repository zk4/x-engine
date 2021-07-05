



``` mermaid
graph TD
A[web 请求?]-->O
O{是否需要?} -->| YES| C
O -->| NO| EE[直接网络?]
C{是否有缓存?} -->|有| D[读缓存?] 
C -->|没有| E[网络模块:请求网络?] --> CACHE[写缓存?]
CACHE --> END[返回?]
D --> END

```

这里有个怎么拦截的问题:

我们只需要拦截 GET 请求, 只拦截  js, css , 不拦截 html. 图片, api 请求.

但 html 则有一个问题,  初次不拦截, 后面得拦截.. 因为路由是改变的 url ,也就是会请求 html.





## 参考

[**网易云音乐大前端团队** WKWebView 请求拦截探索与实践](https://juejin.cn/post/6922625242796032007 )

[WKURLSchemeHandler 的能与不能](https://www.jianshu.com/p/6bae04c91297)

https://juejin.cn/post/6861778055178747911

https://juejin.cn/post/6844904153810993165#heading-34

https://github.com/lilidan/SSWKURL

