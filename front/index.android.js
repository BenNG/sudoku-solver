import React, { Component } from 'react';
import {
  AppRegistry,
} from 'react-native';

import ShowImages from './android/views/showImages';

export default class front extends Component {

  render() {
    return (
      <ShowImages></ShowImages>
    );
  }

}

AppRegistry.registerComponent('front', () => front);