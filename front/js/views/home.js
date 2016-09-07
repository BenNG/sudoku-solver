import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
} from 'react-native';

import {Button} from '../components/button'

export class Home extends Component {
  render() {
    return (
      <View>
        <Text style={styles.welcome}>Welcome from Home</Text>
        <Button onPress={this.props.onPress} title="Go solve sudoku" />
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
