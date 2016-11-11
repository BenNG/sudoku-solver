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
  ListView,
  Image,
  CameraRoll,
} from 'react-native';
let groupByEveryN = require('groupByEveryN');

export default class front extends Component {

  constructor() {
    super();
    this._renderRow = this._renderRow.bind(this);
    const ds = new ListView.DataSource({ rowHasChanged: this._rowHasChanged });
    this.state = {
      dataSource: ds,
    };
  }

  _rowHasChanged(r1, r2) {
    if (r1.length !== r2.length) {
      return true;
    }

    for (let i = 0; i < r1.length; i++) {
      if (r1[i] !== r2[i]) {
        return true;
      }
    }

    return false;
  }

  _fetch(clear = false) {

    let fetchParams = {
      first: 20,
      groupTypes: 'SavedPhotos',
      assetType: 'Photos',
    };


    if (Platform.OS === 'android') {
      // not supported in android
      delete fetchParams.groupTypes;
    }



    CameraRoll.getPhotos(fetchParams)
      .then((data) => this._appendAssets(data), (e) => logError(e));
  }

  _appendAssets(data) {
    let assets = data.edges;


    let state = {
      dataSource: this.state.dataSource.cloneWithRows(
        groupByEveryN(assets, 2)
      ),
    };



    this.setState(state);

  }

  renderImagee(asset) {
    let imageSize = 150;
    let imageStyle = [styles.image, { width: imageSize, height: imageSize }];
    return (
      <Image
        source={asset.node.image}
        style={imageStyle}
        />
    );
  }

  // rowData is an array of images
  _renderRow(assets, a, b) {
    let that = this;
    let images = assets.map((asset) => {

      if (asset === null) {
        return null;
      }
      return that.renderImagee(asset);
    });



    return (
      <View style={styles.row}>
        {images}
      </View>
    );
  }

  render() {

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
        <ListView
          dataSource={this.state.dataSource}
          renderRow={this._renderRow}
          />
      </View>
    );
  }

  componentDidMount() {
    this._fetch();
  }

}

const styles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    flex: 1,
  },
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