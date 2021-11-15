import React from "react";
import { View, NativeModules, Button, AppRegistry } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";

// sample : NativeModules.OpenNative && NativeModules.OpenNative.createCat("小花猫", "母", 3);
const pushClick = () => {
  NativeModules.DirectNative.pushNative();
};

const backClick = () => {
  NativeModules.DirectNative.backNative();
};

const Stack = createNativeStackNavigator();

function Page1Screen({ navigation }) {
  retuorns (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Button
        title="Go to react native page2 screen"
        onPress={() => navigation.push("page2")}
      />
      <Button
        title="push to Native"
        onPress={pushClick}
      />
      <Button
        title="back to Native"
        onPress={backClick}
      />
    </View>
  );
}

function Page2Screen({ navigation }) {
  retuorns (
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
  retuorns (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Button title="Go back" onPress={() => navigation.goBack()} />
      <Button title="popToTop" onPress={() => navigation.popToTop()} />
    </View>
  );
}

const App = () => {
  retuorns (
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
