import React from "react";
import { View, NativeModules, Button, AppRegistry } from "react-native";
import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import Picker from 'react-native-picker';
// import ImagePicker from 'react-native-image-crop-picker';

// 跳http
const pushHttpClick = () => {
  NativeModules.RN_direct.push({
    scheme:"omp",
    host:"10.2.128.24:8080",
    pathname:"",
    fragment:"",
    query:{},
    params:{},
  });
};

// 跳微应用
const pushMicroappClick = () => {
  NativeModules.RN_direct.push({
    scheme:"microapp",
    host:"com.test.microapp.home",
    pathname:"",
    fragment:"",
    query:{},
    params:{},
  });
};

// back
const backClick = () => {
  NativeModules.RN_direct.back({
    scheme:"",
    fragment:"-1",
  });
};


const picker = () => {
  let data = [];
  for(var i=0;i<100;i++){
      data.push(i);
  }

  Picker.init({
      pickerData: data,
      selectedValue: [59],
      onPickerConfirm: data => {
          console.log(data);
          Picker.hide()
      },
      onPickerCancel: data => {
          console.log(data);
          Picker.hide()
      },
      onPickerSelect: data => {
          console.log(data);
          Picker.hide()
      }
  });
  Picker.show();
}

// const ImagePicker = () => {
//   ImagePicker.openPicker({
//     width: 300,
//     height: 400,
//     cropping: true
//   }).then(image => {
//     console.log(image);
//   });
// }

const Stack = createNativeStackNavigator();

function Page1Screen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Button
        title="http"
        onPress={pushHttpClick}
      />
      <Button
        title="microapp"
        onPress={pushMicroappClick}
      />
      <Button
        title="rn page2 screen"
        onPress={() => navigation.push("page2")}
      />
      <Button
        title="back to Native"
        onPress={backClick}
      />
      <Button
        title="third packager ==> picker"
        onPress={picker}
      />
      {/* <Button
        title="third packager ==> ImagePicker"
        onPress={ImagePicker}
      /> */}
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
      <Button
        title="0000000"
        onPress={backClick}
      />
    </View>
  );
}

function Page3Screen({ navigation }) {
  return (
    <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
      <Button
        title="http"
        onPress={pushHttpClick}
      />
      <Button title="Go back" onPress={() => navigation.goBack()} />
      <Button title="popToTop" onPress={() => navigation.popToTop()} />
      <Button
        title="back to Native"
        onPress={backClick}
      />
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