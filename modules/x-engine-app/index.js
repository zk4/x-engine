import React from "react";
import { View, NativeModules, Button, AppRegistry } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";

const buttonClick = () => {
  NativeModules.CreatCat && NativeModules.CreatCat.createCat("小花猫", "母", 3);
};

const Stack = createNativeStackNavigator();

function Page1Screen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Button
        title="Go to page2 screen"
        onPress={() => navigation.push("page2")}
      />
    </View>
  );
}

function Page2Screen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Button
        title="Go to page3"
        onPress={() => navigation.navigate("page3")}
      />
      <Button title="Go back" onPress={() => navigation.goBack()} />
      <Button title="popToTop" onPress={() => navigation.popToTop()} />
    </View>
  );
}

function Page3Screen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Button title="Go back" onPress={() => navigation.goBack()} />
      <Button title="popToTop" onPress={() => navigation.popToTop()} />
    </View>
  );
}

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="page1" component={Page1Screen} />
        <Stack.Screen name="page2" component={Page2Screen} />
        <Stack.Screen name="page3" component={Page3Screen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
};
AppRegistry.registerComponent("App", () => App);
