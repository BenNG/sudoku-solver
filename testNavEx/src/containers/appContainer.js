import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    NavigationExperimental,
} from 'react-native';

const { NavigationStateUtils } = NavigationExperimental;

function initialState() {
    return {
        tabsNavigationState: {
            index: 0,
            routes: [
                { key: 'apple' },
                { key: 'banana' },
                { key: 'orange' },
            ],
        },
        apple: {
            index: 0,
            routes: [{ key: 'Apple Home' }],
        },
        banana: {
            index: 0,
            routes: [{ key: 'Banana Home' }],
        },
        orange: {
            index: 0,
            routes: [{ key: 'Orange Home' }],
        },
    };
}

function reducer(state, action) {
    let { type } = action;
    let tabsNavigationState;
    let tabIndex;
    let tabKey;
    let subNavigationState;
    let route;

    if (type === 'BackAction') {
        type = 'pop';
    }

    if (type === 'push' || type === 'pop') {
        tabsNavigationState = state.tabsNavigationState;
        tabIndex = tabsNavigationState.index;
        tabKey = tabsNavigationState.routes[tabIndex]
        subNavigationState = state[tabKey];
        route = action.route;
    }

    switch (type) {
        case 'push':
            subNavigationState = subNavigationStateUtils.push(subNavigationState, route);
            return Object.assign({}, state, { [tabKey]: subNavigationState });
        case 'pop':
            subNavigationState = subNavigationStateUtils.pop(subNavigationState);
            return Object.assign({}, state, { [tabKey]: subNavigationState });
        case 'selectTab':
            tabKey = action.tabKey; // we will go there
            tabsNavigationState = subNavigationStateUtils.jumpTo(tabsNavigationState, tabKey);
            return Object.assign({}, state, { tabs: tabsNavigationState });
    }
}

export default class AppContainer extends Component {
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
                    Shake or press menu button for dev menu
        </Text>
            </View>
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
