import React from "react";
import { View } from "@tarojs/components";

class CustomJingang extends React.Component {
  constructor(props) {
    super(props);
  }
  render() {
    return (
      <View className="jingang-class">
        <View className="block">1</View>
        <View className="block">2</View>
        <View className="block">3</View>
        <View className="block">4</View>
        <View className="block">5</View>
        <View className="block">6</View>
        <View className="block">7</View>
        <View className="block">8</View>
      </View>
    );
  }
}

export default CustomJingang;
