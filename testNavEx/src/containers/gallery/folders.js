import React, { Component } from 'react';
import {
  Dimensions,
  AppRegistry,
  StyleSheet,
  Platform,
  ActivityIndicator,
  Text,
  View,
  ListView,
  Image,
  CameraRoll,
  TouchableOpacity,
} from 'react-native';
let groupByEveryN = require('groupByEveryN');

const imageMargin = 4;

export default class front extends Component {

  constructor() {
    super();
    this._renderRow = this._renderRow.bind(this);
    this._renderFooterSpinner = this._renderFooterSpinner.bind(this);
    this._onEndReached = this._onEndReached.bind(this);
    this.state = this.initialState();
  }

  initialState() {
    const ds = new ListView.DataSource({ rowHasChanged: this._rowHasChanged });
    return {
      isEnd: false, // end of all pictures
      isLoading: false, // can't trigger several requests in the same time 
      assets: [],
      dataSource: ds,
    };
  }

  fetch(clear) {
    if (!this.state.isLoading) {
      this.setState({ isLoading: true }, () => { this._fetch(clear) });
    }
  }

  _fetch(clear) {
    if (clear) {
      this.setState(this.initialState(), this.fetch);
      return;
    }

    let fetchParams = {
      first: this.props.batchSize,
      groupTypes: 'SavedPhotos',
      assetType: 'Photos',
    };

    if (Platform.OS === 'android') {
      // not supported in android
      delete fetchParams.groupTypes;
    }

    if (this.state.lastCursor) {
      fetchParams.after = this.state.lastCursor;
    }

    CameraRoll.getPhotos(fetchParams)
      .then((data) => this._getPhotosSuccessCB(data), (e) => logError(e));
  }

  _onEndReached() {
    if (!this.state.isEnd) { // here is where we scroll still the end 
      this.fetch();
    }
  }

  _getPhotosSuccessCB(data) {
    let assets = data.edges;
    let newState = {
      isLoading: false,
    };

    if (!data.page_info.has_next_page) {
      newState.isEnd = true;
    }

    if (assets.length) {
      newState.lastCursor = data.page_info.end_cursor;
      newState.assets = this.state.assets.concat(assets);
      newState.dataSource = this.state.dataSource.cloneWithRows(
        groupByEveryN(newState.assets, this.props.imagesPerRow)
      );
    }

    this.setState(newState);
  }

  componentDidMount() {
    this.fetch();
  }

  // private
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

  _renderFooterSpinner() {
    if (!this.state.isEnd) {
      return <ActivityIndicator />;
    }
    return null;
  }

  renderImage(asset) {

    const { width, height } = Dimensions.get('window');
    const realSize = width - 2 * this.props.imagesPerRow * this.props.imageMargin;

    let imageSize = realSize / 3;
    let imageStyle = [styles.image, { width: imageSize, height: imageSize }];
    return (
      <TouchableOpacity key={asset.node.image.uri} onPress={this._onImagePress.bind(this, asset.node.image.uri)}>
        <Image source={asset.node.image} style={imageStyle} />
      </TouchableOpacity>
    );
  }

  _onImagePress(imageName){
    console.log(imageName);

  }

  // rowData is an array of images
  _renderRow(assets, sectionID, rowID, highlightRow) {

    let that = this;
    let images = assets.map((asset) => {

      if (asset === null) {
        return null;
      }
      return that.renderImage(asset);
    });

    return (
      <View style={styles.row}>
        {images}
      </View>
    );
  }

  render() {
    return (
      <ListView style={{ backgroundColor: "red", flex: 1 }}
        dataSource={this.state.dataSource}
        onEndReached={this._onEndReached}
        renderFooter={this._renderFooterSpinner}
        renderRow={this._renderRow} />
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF',
  },
  row: {
    flex: 1,
    flexDirection: 'row',
  },
  image: {
    margin: imageMargin,
  },
});

front.defaultProps = {
  imagesPerRow: 3,
  batchSize: 5,
  imageMargin,
};