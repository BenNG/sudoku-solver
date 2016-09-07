import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
} from 'react-native';

import {Button} from '../components/button'

export class Result extends Component {
  render() {
    return (
      <View>
        <Text style={styles.welcome}>Check this out !</Text>
        <Button onPress={this.props.onPress} title="Solve an other puzzle" />
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
