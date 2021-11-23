export default {
    // 指定小程序的默认启动路 常见情景是从微信聊天列表页下拉启动、小程序列表启动等
    // 如果不填，将默认为 pages 列表的第一项。不支持带页面路径参数
    entryPagePath: "pages/index/index",
    pages: [
        "pages/index/index"
        // 在这里添加需要配置的页面
    ],
    permission: {
        "scope.userLocation": {
            desc: "你的位置信息将用于小程序位置接口的效果展示"
        }
    },
    window: {
        backgroundTextStyle: "light",
        navigationBarBackgroundColor: "#fff",
        navigationBarTitleText: "WeChat",
        navigationBarTextStyle: "black"
    }
};