当前各 repo 分散在各个角落, 要统一管理略为麻烦. 尤其是引擎组自己开发也很痛苦时, 更别说第三方开发人员.

调研一下, 大致有这几种组合方式, yarn workspace, 与 lerna. 混合使用效果最佳.

lerna 负责统一管理版本. yarn workspace 负责包的统一链接.

- monorepo
  - modules
    - x-engine-module-camera
    - x-engine-module-camera
    - ...

