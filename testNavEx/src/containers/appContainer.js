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
import Drawer, { DrawerItem } from './tabs/drawer';

import Icon from 'react-native-vector-icons/FontAwesome';

import {
    AppRegistry,
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
        const {  drawer_open, drawer_trigger_action } = this.props;

        let config = {
            leftIcon: {
                onPress: drawer_trigger_action,
            }
        }
        return (
            <Header {...config} title={sceneProps.scene.route.key}></Header>
        );
    }
    _renderScene(sceneProps) {
        const { navigation, backward, drawer_open, drawer_close } = this.props;
        let tabsNavigationState = navigation.tabs;
        let index = tabsNavigationState.index;
        let key = tabsNavigationState.routes[index].key;

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
                    ref={(ref) => { this._drawer = ref; } }
                    drawerWidth={300}
                    drawerPosition={DrawerLayoutAndroid.positions.Left}
                    renderNavigationView={() => <Drawer navigationKey={key} />}
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

    componentWillReceiveProps({drawer}) {
        const { isDrawerOpen, drawer_cancel_action } = this.props;
        const { trigger } = drawer;

        if (this.props.drawer.trigger !== trigger) {
            isDrawerOpen ? this._drawer.closeDrawer() : this._drawer.openDrawer();
        }

    }

    componentDidMount() {
        // this._drawer.openDrawer(); // __debug__

        const { navigation, backward } = this.props;

        let tabsNavigationState = navigation.tabs;
        let index = tabsNavigationState.index;
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