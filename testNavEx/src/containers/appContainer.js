import Immutable from 'immutable'; // perte de perf mais au moins c'est lisible
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { ActionCreators } from '../actions'
import * as types from '../actions/types';
import Folders from './gallery/folders';
import Folder from './gallery/folder';
import Picture from './gallery/picture';
import Header from './header';

import Icon from 'react-native-vector-icons/FontAwesome';
import Drawer from 'react-native-drawer'

import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Button,
    NavigationExperimental,
    DrawerLayoutAndroid,
    TouchableNativeFeedback,
    BackAndroid,
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

class DefaultView extends Component {
    render() {
        return (
            <View>
                <Text>
                    Default
                </Text>
            </View>
        );
    }
}

class AppContainer extends Component {
    constructor(props) {
        super(props);
        this._renderScene = this._renderScene.bind(this);
        this._renderHeader = this._renderHeader.bind(this);
    }

    _renderHeader(sceneProps) {
        const {  drawer_open } = this.props;

        let config = {
            leftIcon: {
                onPress: drawer_open,
            }
        }
        return (
            <Header {...config} title={sceneProps.scene.route.key}></Header>            
        );
    }
    _renderScene(sceneProps) {
        const { navigation, switchTabApple, switchTabGallery, switchTabBanana, push, pop, forward, backward, drawer_open, drawer_close, drawer } = this.props;
        let tabsNavigationState = navigation.tabs;
        let index = tabsNavigationState.index;
        let key = tabsNavigationState.routes[index].key;

        const actionThenClose = (fn) => {
            return () => {
                fn();
                drawer_close();
            };
        }

        var insideDrawer = (
            <View style={{ flex: 1, backgroundColor: '#fff' }}>
                <Text style={{ margin: 10, fontSize: 15, textAlign: 'left' }}>I'm in the Drawer!</Text>
                <DrawerItem label="apple" targetTab={types.TAB_NAME_APPLE} iconName="apple" isSelected={types.TAB_NAME_APPLE === key} onPress={actionThenClose(switchTabApple)}></DrawerItem>
                <DrawerItem label="gallery" targetTab={types.TAB_NAME_GALLERY} iconName="picture-o" isSelected={types.TAB_NAME_GALLERY === key} onPress={actionThenClose(switchTabGallery)}></DrawerItem>
                <DrawerItem label="banana" targetTab={types.TAB_NAME_BANANA} iconName="music" isSelected={types.TAB_NAME_BANANA === key} onPress={actionThenClose(switchTabBanana)}></DrawerItem>
            </View>
        );

        let componentToRender = DefaultView;

        if (sceneProps.scene.isActive) {
            switch (sceneProps.scene.route.key) {
                case "folders":
                    componentToRender = Folders;
                    break;
                case "folder":
                    componentToRender = Folder;
                    break;
                case "picture":
                    componentToRender = Picture;
                    break;
                default:
                    componentToRender = DefaultView;
                    break;
            }
        }

        return (
            <View style={{ flex: 1 }}>
                <DrawerLayoutAndroid
                    drawerWidth={300}
                    drawerPosition={DrawerLayoutAndroid.positions.Left}
                    renderNavigationView={() => insideDrawer}
                    onDrawerClose={drawer_close}
                    onDrawerOpen={drawer_open}>
                    <View style={{ flexDirection: "column" }}>
                        {this._renderHeader(sceneProps)}
                        {React.createElement(componentToRender)}
                    </View>
                </DrawerLayoutAndroid>
            </View>
        );
    }

    render() {
        const { navigation, backward } = this.props;

        let tabsNavigationState = navigation.tabs;
        let index = tabsNavigationState.index;
        let key = tabsNavigationState.routes[index].key;
        let subNavigationState = navigation[key];

        return (
            <NavigationCardStack
                onNavigateBack={backward}
                navigationState={subNavigationState}
                renderScene={this._renderScene} />
        );
    }

    componentDidMount() {
        // this._drawer.openDrawer(); // __debug__

        const { navigation, backward } = this.props;

        let tabsNavigationState = navigation.tabs;
        let index = tabsNavigationState.index;
        console.log({ index });
        BackAndroid.addEventListener('hardwareBackPress', function () {
            // this.onMainScreen and this.goBack are just examples, you need to use your own implementation here
            // Typically you would use the navigator here to go to the last state.

            if (index !== 0) {
                backward();
                return true;
            }
            return false;
        });
    }
}

function mapStateToProps(state) {
    return {
        navigation: state.navigation,
        drawer: state.drawer,
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
