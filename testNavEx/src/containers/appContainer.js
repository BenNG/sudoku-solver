import Immutable from 'immutable'; // perte de perf mais au moins c'est lisible
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { ActionCreators } from '../actions'

import Icon from 'react-native-vector-icons/FontAwesome';

import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Button,
    NavigationExperimental,
    DrawerLayoutAndroid,
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

        var insideDrawer = (
            <View style={{ flex: 1, backgroundColor: '#fff' }}>
                <Text style={{ margin: 10, fontSize: 15, textAlign: 'left' }}>I'm in the Drawer!</Text>
                <Icon name="rocket" size={30} color="#900" />
                <Button onPress={() => { switchTab("apple"); this._drawer.closeDrawer(); } } title="apple"></Button>
                <Button onPress={() => { switchTab("banana"); this._drawer.closeDrawer(); } } title="banana"></Button>
                <Button onPress={() => { switchTab("orange"); this._drawer.closeDrawer(); } } title="orange"></Button>
            </View>
        );

        return (
            <DrawerLayoutAndroid
                drawerWidth={300}
                drawerPosition={DrawerLayoutAndroid.positions.Left}
                renderNavigationView={() => insideDrawer}
                ref={ref => this._drawer = ref}>
                <View style={{ flex: 1, alignItems: 'center' }}>
                    <Text style={{ margin: 10, fontSize: 15, textAlign: 'right' }}>Hello</Text>
                    <Text style={{ margin: 10, fontSize: 15, textAlign: 'right' }}>World!</Text>
                    <Text>
                        {sceneProps.scene.route.key}
                    </Text>
                    <Button onPress={() => { push(sceneProps.scene.route.key + Date.now()) } } title="push"></Button>
                    <Button onPress={() => { pop() } } title="pop"></Button>
                </View>
            </DrawerLayoutAndroid>
        );
    }

    render() {
        let { navigation } = this.props;
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

export default connect(mapStateToProps, mapDispatchToProps)(AppContainer);

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
