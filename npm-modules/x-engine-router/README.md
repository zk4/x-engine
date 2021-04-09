# x-engine-router

- 重写VueRouter的push, 拦截vue跳转
- 重写VueRouter的go, 拦截vue跳转

- 通过npm安装包

```
npm install x-engine-router
```


- 使用方式

```javascript
import xxx from 'x-engine-router'
// router.index
// 参数1: VueRouter实例
// 参数2: scheme tip: 
//       omp / http / https / microapp / file
xxx(VueRouter, 'omp');
```


