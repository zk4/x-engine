export default {
    namespaced:true,
    state:{
        title:'',
        publisher:'',
        detail:'',
        fileList:[],
        grade:0,
        typeId:0,
        pushModes:0
    },
    mutations:{
        publicedNotice(state,obj) {
            state[obj.name] = obj.value;
            console.log(state[obj.name]);
        }
        
    },
    actions:{
        publicedNotice(state,obj) {
            state[obj.name] = obj.value;
            console.log(state[obj.name]);
        }
    },
    getters:{}
}