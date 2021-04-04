# ZKTYRouter

- 重写VueRouter的push
- 重写VueRouter的go

- 通过npm安装包

```
npm install @zkty-team/vue-router
```


- 使用方式

```javascript
import xxx from '@zkty-team/vue-router'
// router.index
// 参数1: VueRouter实例
// 参数2: scheme 
//       scheme tip:
//       omp / http / https / microapp / file
xxx.intercept(VueRouter, 'omp');
```


