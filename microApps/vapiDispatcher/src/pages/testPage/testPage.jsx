import { Component } from "react";
import { View, Button } from "@tarojs/components";
import Taro from "@tarojs/taro";
import "./testPage.css";

export default class Index extends Component {
  componentDidMount() {
    const instance = Taro.getCurrentInstance();
    console.log(instance.router.params);
  }

  backPage() {
    Taro.navigateBack()
  }

  render() {
    const instance = Taro.getCurrentInstance();
    return (
      <View>
        <View>占位</View>
        <View>占位</View>
        <View>占位</View>
        <View>占位</View>
        <View>占位</View>
        <View>占位</View>
        <View>{process.env.TARO_ENV}</View>
        <View>{instance.router.params.id}</View>
        <View>{instance.router.params.name}</View>
        <Button onClick={() => this.backPage()}>back</Button>
      </View>
    );
  }
}
