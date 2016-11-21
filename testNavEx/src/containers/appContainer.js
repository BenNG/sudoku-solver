import Immutable from 'immutable';
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


function initialState() {
    return {
        navigation: {
            tabs: {
                index: 0,
                routes: [
                    { key: 'apple' },
                    { key: 'banana' },
                    { key: 'orange' },
                ],
            },
            apple: {
                index: 0,
                routes: [
                    { key: "details apple" },
                ]
            },
            banana: {
                index: 0,
                routes: [
                    { key: "details banana" },
                ]
            },
            orange: {
                index: 0,
                routes: [
                    { key: "details orange" },
                ]
            },
        },
    };
}

function navigationStateReducer(state, action) {
    let { type } = action;
    let { navigation } = state;
    let tabsNavigationState = navigation.tabs;
    let index;
    let key;
    let subNavigationState;
    let newState;
    let returnObject = {}
    let imState;


    switch (type) {
        case 'push':
            index = tabsNavigationState.index;
            key = tabsNavigationState.routes[index].key;
            subNavigationState = navigation[key];
            newState = NavigationStateUtils.push(subNavigationState, action.route);

            imState = Immutable.fromJS(state);
            return imState.setIn(['navigation', key], newState).toJS();

        case 'selectTab':
            tabKey = action.tabKey; // we will go there
            newState = NavigationStateUtils.jumpTo(tabsNavigationState, tabKey);

            imState = Immutable.fromJS(state);
            return imState.setIn(['navigation', 'tabs'], newState).toJS();
    }
}


export default class AppContainer extends Component {
    constructor(props) {
        super(props);
        this._renderScene = this._renderScene.bind(this);
        this.navigate = this.navigate.bind(this);
        this.state = initialState();
    }

    navigate(state, action) {
        const newState = navigationStateReducer(state, action);

        if (state !== newState) {
            this.setState(newState);
        }
    }

    _renderScene(sceneProps) {
        return (
            <View>
                <Text>
                    {sceneProps.scene.route.key}
                </Text>
                <Button onPress={() => { this.navigate(this.state, { type: "selectTab", tabKey: "apple" }) } } title="apple"></Button>
                <Button onPress={() => { this.navigate(this.state, { type: "selectTab", tabKey: "banana" }) } } title="banana"></Button>
                <Button onPress={() => { this.navigate(this.state, { type: "selectTab", tabKey: "orange" }) } } title="orange"></Button>

                <Button onPress={() => { this.navigate(this.state, { type: "push", route: { key: sceneProps.scene.route.key + Date.now() } }) } } title="push"></Button>
                <Button onPress={() => { this.navigate(this.state, { type: "pop" }) } } title="pop"></Button>
            </View>
        );
    }

    render() {

        let { navigation } = this.state;
        let tabsNavigationState;
        let index;
        let key;
        let subNavigationState;
        let newState;
        let returnObject = {}

        tabsNavigationState = navigation.tabs;
        index = tabsNavigationState.index;
        key = tabsNavigationState.routes[index].key;
        subNavigationState = navigation[key];

        return (
            <NavigationCardStack
                navigationState={subNavigationState}
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
