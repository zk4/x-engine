
`
undefined
`



## setNavTitle



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | "title" | 导航条的文字 |
| titleColor | string |  | "#000000" | 16进制的颜色色值 |
| titleSize | int |  | 16 | 字体大小 |


## setNavLeftBtn



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | "menu" | 导航条右边按钮的文字 |
| titleColor | string |  | "#000000" | 16进制的颜色色值 |
| titleSize | int |  | 16 | 导航条文字的大小 |
| titleBig | string |  |  | 按钮文字粗细  |
| titleFontName | string |  |  | 设置字体, android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium |
| isBoldFont | bool |  |  | 在不设置 titleFontName 时, 是否使用系统粗体. |
| icon | string | true | "" | 见下方说明 |
| iconSize | Array\<double\> |  | ["20","20"] | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | true | [{"icon":"","iconSize":"20","title":"1"},{"icon":"","iconSize":"20","title":"2"},{"icon":"","iconSize":"20","title":"3"}] |  |
| showMenuImg | string | true | "false" | 见下方说明 |
| popWidth | string | true | "200" | menu的宽 |
| __event__ | string | true |  |  |


## setNavRightBtn



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | "menu" | 导航条右边按钮的文字 |
| titleColor | string |  | "#000000" | 16进制的颜色色值 |
| titleSize | int |  | 16 | 导航条文字的大小 |
| titleBig | string |  |  | 按钮文字粗细  |
| titleFontName | string |  |  | 设置字体, android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium |
| isBoldFont | bool |  |  | 在不设置 titleFontName 时, 是否使用系统粗体. |
| icon | string | true | "" | 见下方说明 |
| iconSize | Array\<double\> |  | ["20","20"] | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | true | [{"icon":"","iconSize":"20","title":"1"},{"icon":"","iconSize":"20","title":"2"},{"icon":"","iconSize":"20","title":"3"}] |  |
| showMenuImg | string | true | "false" | 见下方说明 |
| popWidth | string | true | "200" | menu的宽 |
| __event__ | string | true |  |  |


## setNavRightMenuBtn



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| title | string |  | "menu" | 导航条右边按钮的文字 |
| titleColor | string |  | "#000000" | 16进制的颜色色值 |
| titleSize | int |  | 16 | 导航条文字的大小 |
| titleBig | string |  |  | 按钮文字粗细  |
| titleFontName | string |  |  | 设置字体, android/iOS可能有所差异 PingFangSC-Regular / PingFangSC-Semibold / PingFangSC-Medium |
| isBoldFont | bool |  |  | 在不设置 titleFontName 时, 是否使用系统粗体. |
| icon | string | true | "" | 见下方说明 |
| iconSize | Array\<double\> |  | ["20","20"] | 图片的宽高 |
| popList | Array\<Map\<string,string\>\> | true | [{"icon":"","iconSize":"20","title":"1"},{"icon":"","iconSize":"20","title":"2"},{"icon":"","iconSize":"20","title":"3"}] |  |
| showMenuImg | string | true | "false" | 见下方说明 |
| popWidth | string | true | "200" | menu的宽 |
| __event__ | string | true |  |  |


## setNavRightMoreBtn



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| btns | Array\<NavBtnDTO\> |  | [{"title":"right1","titleColor":"#000000","titleSize":16,"iconSize":["20","20"]},{"title":"","icon":"/assets/search.png","titleColor":"#000000","titleSize":16,"iconSize":["20","20"]}] |  |


## navigatorPush

跳转页面.

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | true | "" | 跳转地址 |
| params | string | true |  | 其余参数 |


## navigatorBack

返回层级. 如果url为空则返回上一级, 堆栈中有对应地址, 则返回该界面

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| url | string | true | "" | 跳转地址 |
| params | string | true |  | 其余参数 |


## navigatorRouter

跳转页面.

	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| type | string |  |  | 跳转类型 |
| uri | string |  |  | 跳转目标 |
| path | string |  |  | 跳转参数 |


## setNavSearchBar



	
**参数说明**

| name                        | type      | optional | default   | comment  |
| --------------------------- | --------- | -------- | --------- |--------- |
| cornerRadius | int |  | 5 | 搜索框圆角大小 |
| backgroundColor | string |  | "#FF0000" | 搜索框背景颜色 |
| iconSearch | string |  | "" | 搜索框里搜索图片 |
| iconSearchSize | Array\<double\> |  | [20,20] | 搜索框里搜索图片大小 |
| iconClear | string |  | "" | 搜索框里清空图片 |
| iconClearSize | Array\<double\> |  | [20,20] | 搜索框里清空图片大小 |
| textColor | string |  | "#000000" | 搜索框文本颜色 |
| fontSize | int |  | 16 | 搜索框文本字体大小 |
| placeHolder | string |  | "默认文字" | 搜索框占位符 |
| placeHolderFontSize | int |  | 16 | 搜索框占位符大小 |
| isInput | bool |  | true | 搜索框是否添加点击事件 |
| becomeFirstResponder | bool |  | false | 搜索框是否获取焦点 |
| __event__ | string | true |  |  |

    |  |

    