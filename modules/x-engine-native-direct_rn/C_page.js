import React, { Component } from 'react';
import {
    Text,
    View,
    TouchableOpacity,
    BackHandler,
} from 'react-native';

export default class APage extends Component {
    static navigationOptions = {
        title: 'C页面',//标题
    };

    render() {
        return (
            <View>
                <TouchableOpacity
                    onPress={this.gotoApage
                    //this.props.navigation.goBack()
                    }>
                    <View style={{
                        width: "100%", height: 50, justifyContent: 'center', backgroundColor: '#ff7102'
                        , alignItems: 'center'
                    }}>
                        <Text>点我去A页面</Text>
                    </View>
                </TouchableOpacity>
            </View>
        );
    }

    //组件初始渲染执行完毕后调用
    componentDidMount() {
        //如果当前是Android系统，则添加back键按下事件监听
        BackHandler.addEventListener('hardwareBackPress', this.onBackPress);
    }

    //组件被卸载前会执行
    componentWillUnmount() {
        //如果当前是Android系统，则移除back键按下事件监听
        BackHandler.removeEventListener('hardwareBackPress', this.onBackPress);
    }

    onBackPress = () => {
        this.gotoApage();
        return true;
    };

    gotoApage=()=>{
        this.props.navigation.navigate('pa');
    }
}