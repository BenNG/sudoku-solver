import Immutable from 'immutable'; // perte de perf mais au moins c'est lisible
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { ActionCreators } from '../actions'
import * as types from '../actions/types';

import Icon from 'react-native-vector-icons/FontAwesome';

import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Button,
    NavigationExperimental,
    DrawerLayoutAndroid,
    TouchableNativeFeedback,
} from 'react-native';

const {
    CardStack: NavigationCardStack,
    StateUtils: NavigationStateUtils,
} = NavigationExperimental;


class DrawerItem extends Component {
    render() {
        const itemStyle = this.props.isSelected ? styles.selectedItem : styles.item;
        return (
            <TouchableNativeFeedback onPress={this.props.onPress} style={{ flexDirection: 'row' }}>
                <View style={itemStyle} >
                    <Icon name={this.props.iconName} size={20} color="#222" style={styles.icon} />
                    <Text>{this.props.label}</Text>
                </View>
            </TouchableNativeFeedback>
        );
    }
}

class AppContainer extends Component {
    constructor(props) {
        super(props);
        this._renderScene = this._renderScene.bind(this);
    }

    _renderScene(sceneProps) {
        let { navigation } = this.props;
        let tabsNavigationState = navigation.tabs;
        let index = tabsNavigationState.index;
        let key = tabsNavigationState.routes[index].key;
        const { switchTabApple, switchTabOrange, switchTabBanana, push, pop } = this.props;

        var insideDrawer = (
            <View style={{ flex: 1, backgroundColor: '#fff' }}>
                <Text style={{ margin: 10, fontSize: 15, textAlign: 'left' }}>I'm in the Drawer!</Text>
                <DrawerItem label="apple"  targetTab="apple" iconName="apple" isSelected={types.TAB_NAME_APPLE === key} onPress={switchTabApple}></DrawerItem>
                <DrawerItem label="orange" targetTab="orange" iconName="glass" isSelected={types.TAB_NAME_ORANGE === key} onPress={switchTabOrange}></DrawerItem>
                <DrawerItem label="banana" targetTab="banana" iconName="music" isSelected={types.TAB_NAME_BANANA === key} onPress={switchTabBanana}></DrawerItem>
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

    componentDidMount() {
        this._drawer.openDrawer(); // __debug__
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
    item: {
        flexDirection: 'row',
        alignItems: 'center',
    },
    selectedItem: {
        flexDirection: 'row',
        alignItems: 'center',
        backgroundColor: 'red'
    },
    icon: {
        margin: 10,
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
