import React, { Component } from 'react';
import {
    Text,
    View,
    TouchableOpacity
} from 'react-native';
import { Colors } from 'react-native/Libraries/NewAppScreen';

export default class Bpage extends Component {
    static navigationOptions = {    //上标题
        title: 'B页面',
    };

    render() {
        const { navigate } = this.props.navigation;
        return (
            <View>
                <TouchableOpacity
                    onPress={() => {
                        navigate('pc');
                    }}>
                    <View style={{
                        width: "100%", height: 50, justifyContent: 'center', backgroundColor: '#33da33'
                        , alignItems: 'center'
                    }}>
                        <Text style={{color:'#ffffff'}}>点我去C页面</Text>
                    </View>
                </TouchableOpacity>
            </View>

        );
    }
}