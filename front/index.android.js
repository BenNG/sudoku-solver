/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Platform,
  Text,
  View,
  Image,
  CameraRoll,
} from 'react-native';

export default class front extends Component {

  _fetch(clear = false) {

    var fetchParams = {
      first: 5,
      groupTypes: 'SavedPhotos',
      assetType: 'Photos',
    };

    console.log("-----------------------------");
    console.log(this.props);
    console.log("-----------------------------");
    console.log(Platform.OS);

    if (Platform.OS === 'android') {
      // not supported in android
      delete fetchParams.groupTypes;
    }


    console.log("-----------------------------");
    console.log(fetchParams);

    CameraRoll.getPhotos(fetchParams)
      .then((data) => this._appendAssets(data), (e) => logError(e));
  }

  _appendAssets(data) {
    var assets = data.edges;

    console.log("-----------------------------");
    console.log(assets[0].node.image.uri);

    let state = {
      imageToShow: assets[0],
    };

    this.setState(state);

  }

  renderImage(asset) {
    var imageSize = 150;
    var imageStyle = [styles.image, { width: imageSize, height: imageSize }];
    return (
      <Image
        source={asset.node.image}
        style={imageStyle}
        />
    );
  }


  render() {

    console.log("-------- state ------------------");
    console.log(this.state);

    let image;
    if(this.state && this.state.imageToShow){
      image = this.renderImage(this.state.imageToShow);
    }

    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Welcome to React Native!
        </Text>
        <Text style={styles.instructions}>
          To get started, edit index.android.js
        </Text>
        <Text style={styles.instructions}>
          Double tap R on your keyboard to reload,{'\n'}
          Shake or press menu button for dev menu
        </Text>
        {image}
      </View>
    );
  }

  componentDidMount() {
    console.log("componentDidMount");
    this._fetch();
  }

}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  image: {
    margin: 4,
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('front', () => front);