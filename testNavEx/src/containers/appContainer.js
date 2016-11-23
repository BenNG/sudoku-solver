import Immutable from 'immutable'; // perte de perf mais au moins c'est lisible
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { ActionCreators } from '../actions'

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

class AppContainer extends Component {
    constructor(props) {
        super(props);
        this._renderScene = this._renderScene.bind(this);
    }

    _renderScene(sceneProps) {

        const { switchTab, push, pop } = this.props;

        return (
            <View>
                <Text>
                    {sceneProps.scene.route.key}
                </Text>
                <Button onPress={() => { switchTab("apple") } } title="apple"></Button>
                <Button onPress={() => { switchTab("banana") } } title="banana"></Button>
                <Button onPress={() => { switchTab("orange") } } title="orange"></Button>

                <Button onPress={() => { push(sceneProps.scene.route.key + Date.now()) } } title="push"></Button>
                <Button onPress={() => { pop() } } title="pop"></Button>
            </View>
        );
    }

    render() {

        let { navigation } = this.props;
        // console.log(navigation);
        let tabsNavigationState = navigation.tabs;
        let index = tabsNavigationState.index;
        let key = tabsNavigationState.routes[index].key;
        let subNavigationState = navigation[key];

        return (
            <NavigationCardStack
                navigationState={subNavigationState}
                renderScene={this._renderScene}
                />
        );
    }
}

function mapStateToProps(state) {
    return {
        navigation: state.navigation,
    };
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators(ActionCreators, dispatch);
}

export default connect(mapStateToProps,mapDispatchToProps)(AppContainer);

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
