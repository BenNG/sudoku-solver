import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';
import AppContainer from './src/containers/appContainer.js';


export default class testNavEx extends Component {
  render() {
    return (
      <AppContainer {...this.props}/>
    );
  }
}

AppRegistry.registerComponent('testNavEx', () => testNavEx);
