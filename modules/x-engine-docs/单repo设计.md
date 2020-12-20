当前各 repo 分散在各个角落, 要统一管理略为麻烦. 尤其是引擎组自己开发也很痛苦时, 更别说第三方开发人员.

调研一下, 大致有这种组合方式, yarn workspace, 与 lerna.





- x-engine-all
  - modules
    - x-engine-module-camera
    - x-engine-module-camera
    - ...

