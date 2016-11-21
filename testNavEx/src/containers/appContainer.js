import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Button,
    NavigationExperimental,
} from 'react-native';

const {
    CardStack: NavigationCardStack,
    StateUtils: NavigationStateUtils,
} = NavigationExperimental;


function reducer(state, action) {

    console.log(state);

    switch (type) {
        case 'selectTab':
            tabKey = action.tabKey; // we will go there
            tabsNavigationState = NavigationStateUtils.jumpTo(state, tabKey);
            return Object.assign({}, state, { tabs: tabsNavigationState });
    }
}


export default class AppContainer extends Component {
    constructor(props) {
        super(props);
        this.state = {
            navigation: {
                index: 0,
                routes: [
                    { key: 'page 1' },
                    { key: 'page 2' },
                ],
            },
        };
    }

    navigate(state, action) {
        const newState = reducer(state, action);

        if (state !== newState) {
            this.setState(newState);
        }
    }

    _renderScene(sceneProps) {
        console.log(sceneProps);
        return (
            <View>
                <Text>
                    {sceneProps.scene.route.key}
                </Text>
            </View>
        );
    }

    render() {
        return (
            <NavigationCardStack
                navigationState={this.state.navigation}
                renderScene={this._renderScene}
                />
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#F5FCFF',
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
