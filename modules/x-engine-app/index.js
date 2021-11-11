import React from "react";
import { View, NativeModules, Button, AppRegistry } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";

// 跳原生
const pushNativeClick = () => {
  // NativeModules.RN_direct.pushNative("UIViewController");
  NativeModules.RN_direct.pushNative({
    scheme:"http",
    host:"www.baidu.com",
    path:"/",
    pathname:"",
    fragment:"",
    query:{},
    params:{},
  });  
};


// 跳微应用
const pushMicroappClick = () => {
  NativeModules.RN_direct.pushMicroapp("com.zkty.microapp.home")
};

// 跳http
const pushHttpClick = () => {
  NativeModules.RN_direct.pushHttp("http://www.baidu.com")
};

// back
const backClick = () => {
  NativeModules.RN_direct.backNative();
};

const Stack = createNativeStackNavigator();

function Page1Screen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Button
        title="Go to react native page2 screen"
        onPress={() => navigation.push("page2")}
      />
      <Button
        title="push to Native"
        onPress={pushNativeClick}
      />
      <Button
        title="push to microapp"
        onPress={pushMicroappClick}
      />
      <Button
        title="push to http"
        onPress={pushHttpClick}
      />
      <Button
        title="back to Native"
        onPress={backClick}
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