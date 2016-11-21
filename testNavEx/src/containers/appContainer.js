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
    let { type } = action;


    switch (type) {
        case 'selectTab':
            tabKey = action.tabKey; // we will go there
            let newState = NavigationStateUtils.jumpTo(state, tabKey);
            return Object.assign({}, newState);
    }
}


export default class AppContainer extends Component {
    constructor(props) {
        super(props);
        this._renderScene = this._renderScene.bind(this);
        this.navigate = this.navigate.bind(this);

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

        // console.log(o);
        if (state !== newState) {
            let o = { navigation: {} };
            o.navigation = Object.assign({}, newState);
            this.setState(o);
        }
    }

    _renderScene(sceneProps) {
        return (
            <View>
                <Text>
                    {sceneProps.scene.route.key}
                </Text>
                <Button onPress={() => { this.navigate(this.state.navigation, { type: "selectTab", tabKey: "page 1" }) } } title="page 1"></Button>
                <Button onPress={() => { this.navigate(this.state.navigation, { type: "selectTab", tabKey: "page 2" }) } } title="page 2"></Button>
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
