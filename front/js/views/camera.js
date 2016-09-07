import React, { Component } from 'react';
import {
  StyleSheet,
  Dimensions,
  Text,
  View,
} from 'react-native';

import Cam from 'react-native-camera';
import {Button} from '../components/button'

export class Camera extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Take your sudoku here !</Text>
        <Cam
          ref={(cam) => {
            this.camera = cam;
          }}
          style={styles.preview}
          aspect={Cam.constants.Aspect.fill}>
          <Text style={styles.capture} onPress={this.takePicture.bind(this)}>[CAPTURE]</Text>
        </Cam>
        <Button onPress={this.props.onPress} title="Take picture !" />
        <Button onPress={this.props.goBack} title="return" />
      </View>
    );
  }
  takePicture() {
  this.camera.capture()
    .then((data) => console.log(data))
    .catch(err => console.error(err));
}
}

const styles = StyleSheet.create({
  container: {
    flex: 1
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
    preview: {
    flex: 1,
    justifyContent: 'flex-end',
    alignItems: 'center',
    height: Dimensions.get('window').height,
    width: Dimensions.get('window').width
  },
  capture: {
    flex: 0,
    backgroundColor: '#fff',
    borderRadius: 5,
    color: '#000',
    padding: 10,
    margin: 40
  }
});
