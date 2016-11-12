import React, { Component } from 'react';
import {
    StyleSheet,
    PixelRatio,
    NavigationExperimental,
} from 'react-native';

import Home from './home';

const {
    NavigationCardStack,
    NavigationStateUtils,
} = NavigationExperimental;

export default class MyVerySimpleNavigator extends Component {

    constructor(props, context) {
        super(props, context);

        this._onPushRoute = this.props.onNavigationChange.bind(null, 'push');
        this._onPopRoute = this.props.onNavigationChange.bind(null, 'pop');
        this._renderScene = this._renderScene.bind(this);
    }

    render() {
        return (
            <NavigationCardStack
                onNavigateBack={this._onPopRoute}
                navigationState={this.props.navigationState}
                renderScene={this._renderScene}
                style={styles.navigator}
                />
        );
    }

    // _renderScene(sceneProps) {
    //     return (
    //         <MyVeryComplexScene
    //             route={sceneProps.scene.route}
    //             onPushRoute={this._onPushRoute}
    //             onPopRoute={this._onPopRoute}
    //             onExit={this.props.onExit}
    //             />
    //     );
    // }
    _renderScene(sceneProps) {
        return (
            <Home />
        );
    }
}

const styles = StyleSheet.create({
    navigator: {
        flex: 1,
    },
    scrollView: {
        marginTop: 64
    },
    row: {
        padding: 15,
        backgroundColor: 'white',
        borderBottomWidth: 1 / PixelRatio.get(),
        borderBottomColor: '#CDCDCD',
    },
    rowText: {
        fontSize: 17,
    },
    buttonText: {
        fontSize: 17,
        fontWeight: '500',
    },
});