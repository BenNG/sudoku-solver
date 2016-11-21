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
        },
    };
}

function navigationStateReducer(state, action) {
    let { type } = action;
    let { navigation } = state;

    switch (type) {
        case 'selectTab':
            let tabsNavigationState = navigation.tabs; 
            tabKey = action.tabKey; // we will go there
            let newState = NavigationStateUtils.jumpTo(tabsNavigationState, tabKey);

            let o = { navigation: { tabs: {} } };
            o.navigation.tabs = Object.assign({}, newState);
            return o;
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
            </View>
        );
    }

    render() {

        let subNavigationState = this.state.navigation.tabs;
        // console.log(subNavigationState);
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
