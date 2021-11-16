import { Component } from 'react'
import { View, Button } from '@tarojs/components'
import { NativeModules } from "react-native";
import './index.css'

export default class Index extends Component {

  componentWillMount () { }

  componentDidMount () { }

  componentWillUnmount () { }

  componentDidShow () { }

  componentDidHide () { }

  // 跳http
  httpClick() {
    NativeModules.RN_direct.push({
      scheme:"omp",
      host:"www.baidu.com",
      pathname:"",
      fragment:"",
      query:{},
      params:{},
    });
  };

  // 跳微应用
  microappClick = () => {
    NativeModules.RN_direct.push({
      scheme:"microapp",
      host:"com.test.microapp.home",
      pathname:"",
      fragment:"",
      query:{},
      params:{},
    });
  };

  render () {
    return (
      <View className='index'>
        <Button onClick={() => this.httpClick()} className='button-class'>http</Button>
        <Button onClick={() => this.microappClick()}  className='button-class'>microappClick</Button>
      </View>
    )
  }
}
