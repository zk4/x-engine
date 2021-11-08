import React from "react";

import {
  StyleSheet,
  View,
  NativeModules,
  Button,
} from "react-native";

const buttonClick = () => {
  NativeModules.CreatCat && NativeModules.CreatCat.createCat("小花猫", "母", 3);
};

const HomeScreen = ({navigation}) => {
  return (
    <View
      style={{
        marginTop: 100,
        marginLeft: 30,
        marginRight: 30,
        marginHorizontal: 10,
      }}
    >
      <View style={styles.clickButtonStyle}>
        <Button
          title={"click"}
          color={"white"}
          onPress={buttonClick}
        />
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  clickButtonStyle: {
    height: 40,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: "gray",
    backgroundColor: "gray",
  },
});
export default HomeScreen;
