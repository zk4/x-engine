import React, { Component } from 'react';
import {
    Text,
    View,
    TouchableOpacity
} from 'react-native';

export default class APage extends Component {
    static navigationOptions = {
        title: 'A页面',//标题
    };

    render() {
        const { navigate } = this.props.navigation;
        return (
            <View>
                <TouchableOpacity
                    onPress={() => {
                        navigate('pb');
                    }}>
                    <View style={{width:"100%",height:50,justifyContent:'center',backgroundColor:'#f0f0f0'
                ,alignItems:'center'}}>
                        <Text>点我去B页面</Text>
                    </View>
                </TouchableOpacity>
            </View>
        );
    }
}