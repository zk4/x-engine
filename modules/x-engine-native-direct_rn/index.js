import { AppRegistry } from 'react-native';
import {name as appName} from './app.json';

import a_page from './A_page';
import b_page from './B_page';
import c_page from './C_page';
import {
    createStackNavigator,
} from '@react-navigation';

import {
    createAppContainer,
} from 'react-navigation';

const AppNavigator = createStackNavigator({
    pa: {screen: a_page},
    pb: {screen: b_page},
    pc: {screen: c_page},
}, {
    initialRouteName: 'pa',
});


const App = createAppContainer(AppNavigator);

AppRegistry.registerComponent(appName, () => App);


// import {
//   AppRegistry,
// } from "react-native";

// import HomeScreen from "./HomeScreen";
// import ProfileScreen from "./ProfileScreen";
// import {
//   createStackNavigator,
// } from 'react-navigation-stack';

// import {
//   createAppContainer,
// } from 'react-navigation';

// const AppNativigator = createStackNavigator({
//   //这里注册了每个独立的页面。
//   hs: {screen: HomeScreen},
//   ps: {screen: ProfileScreen},
// });

// const App = createAppContainer(AppNativigator);

// AppRegistry.registerComponent("App", () => App);

// function HomeScreen() {
//   return (
//     <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
//       <Text>Home Screen</Text>
//     </View>
//   );
// }

// function DetailsScreen() {
//   return (
//     <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
//       <Text>Details Screen</Text>
//     </View>
//   );
// }

// const Stack = createNativeStackNavigator();

// function App() {
//   return (
//     <NavigationContainer>
//       <Stack.Navigator initialRouteName="Home">
//         <Stack.Screen name="Home" component={HomeScreen} />
//         <Stack.Screen name="Details" component={DetailsScreen} />
//       </Stack.Navigator>
//     </NavigationContainer>
//   );
// }


// export default App;

// class HomeScreen extends React.Component {
//   static navigationOptions = {
//     title: 'Welcome',
//   };
//   render() {
//     const { navigate } = this.props.navigation;
//     return (
//       <Button
//         title="Go to Jane's profile"
//         onPress={() =>
//           navigate('Profile', { name: 'Jane' })
//         }
//       />
//     );
//   }
// }


// const buttonClick = () => {
//   NativeModules.CreatCat && NativeModules.CreatCat.createCat("小花猫", "母", 3);
// };


// const App = ({navigation}) => {
//   return (
//     <View
//       style={{
//         marginTop: 100,
//         marginLeft: 30,
//         marginRight: 30,
//         marginHorizontal: 10,
//       }}
//     >
//       <View style={styles.clickButtonStyle}>
//         {/* <Button
//           title={"click"}
//           color={"white"}
//           onPress={buttonClick}
//         /> */}

//       <Button
//         title="Go to Jane's profile"
//         onPress={() =>
//           navigation.navigate('Profile', { name: 'Jane' })
//         }
//       />
//       </View>
//     </View>
//   );
// };

// const styles = StyleSheet.create({
//   clickButtonStyle: {
//     height: 40,
//     borderRadius: 10,
//     borderWidth: 1,
//     borderColor: "gray",
//     backgroundColor: "gray",
//   },
// });




// class RNHighScores extends React.Component {
//   render() {
//     var contents = this.props['scores'].map((score) => (
//       <Text key={score.name}>
//         {score.name}:{score.value}
//         {'\n'}
//       </Text>
//     ));
//     return (
//       <View style={styles.container}>
//         <Text style={styles.highScoresTitle}>
//           2048 High Scores!
//         </Text>
//         <Text style={styles.scores}>{contents}</Text>
//         <Button onClick={()=>genCat()}></Button>
//       </View>
//     );
//   }
// }

// const styles = StyleSheet.create({
//   container: {
//     flex: 1,
//     justifyContent: 'center',
//     alignItems: 'center',
//     backgroundColor: '#FFFFFF'
//   },
//   highScoresTitle: {
//     fontSize: 20,
//     textAlign: 'center',
//     margin: 10
//   },
//   scores: {
//     textAlign: 'center',
//     color: '#333333',
//     marginBottom: 5
//   }
// });

// Module name
// AppRegistry.registerComponent('RNHighScores', () => RNHighScores);
