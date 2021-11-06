import React from "react";
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  NativeModules,
  Button,
  Alert,
} from "react-native";

// const GenCat = () => {
//   NativeModules.CreatCat && NativeModules.CreatCat.createCat("小花猫", "母", 3);
// };

const buttonClick = () => {
  NativeModules.CreatCat && NativeModules.CreatCat.createCat("小花猫", "母", 3);
};

const App = () => {
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

AppRegistry.registerComponent("App", () => App);

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
