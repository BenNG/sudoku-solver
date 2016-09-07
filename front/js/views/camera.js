import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
} from 'react-native';

import {Button} from '../components/button'

export class Camera extends Component {
  render() {
    return (
      <View>
        <Text style={styles.welcome}>Take your sudoku here !</Text>
        <Button onPress={this.props.onPress} title="Take picture !" />
        <Button onPress={this.props.goBack} title="return" />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
});
