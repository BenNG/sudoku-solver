import React, { Component } from 'react';
import {
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

export default class ShowImages extends Component {

    constructor() {
        super();
        this._renderRow = this._renderRow.bind(this);
        this._renderFooterSpinner = this._renderFooterSpinner.bind(this);
        this._onEndReached = this._onEndReached.bind(this);

        this.state = this.getInitialState();
    }

    getInitialState() {
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
            this.setState(this.getInitialState(), this.fetch);
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

    renderImage(asset) {
        let imageSize = 150;
        let imageStyle = [styles.image, { width: imageSize, height: imageSize }];
        return (
            <TouchableOpacity key={asset} onPress={this._getPhotosSuccessCB.bind(this, asset)}>
                <Image source={asset.node.image} style={imageStyle} />
            </TouchableOpacity>
        );
    }

    _renderFooterSpinner() {
        if (!this.state.isEnd) {
            return <ActivityIndicator />;
        }
        return null;
    }

    // rowData is an array of images
    _renderRow(assets, a, b) {
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
                    onEndReached={this._onEndReached}
                    renderFooter={this._renderFooterSpinner}
                    renderRow={this._renderRow}
                    />
            </View>
        );
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

ShowImages.defaultProps = {
    imagesPerRow: 2,
    batchSize: 5,
};