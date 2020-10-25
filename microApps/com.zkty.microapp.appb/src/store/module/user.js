const user = {
    state: { //存储定义的变量
        active: window.localStorage.getItem("SD_SETACTIVE")
    },
    mutations: { //更改state里面的值定义的一些方法
        setactive(state, active) {
            state.active = active;
        },
    },
    getters: {//依赖state里面的值衍生的新的变量

    },
    action: {//提交mutations
        
    }
}

export default user