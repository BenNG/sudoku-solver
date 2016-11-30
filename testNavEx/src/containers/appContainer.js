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
    }

    _renderScene(sceneProps) {
        let { navigation } = this.props;
        let tabsNavigationState = navigation.tabs;
        let index = tabsNavigationState.index;
        let key = tabsNavigationState.routes[index].key;
        const { switchTabApple, switchTabGallery, switchTabBanana, push, pop, forward, backward } = this.props;

        var insideDrawer = (
            <View style={{ flex: 1, backgroundColor: '#fff' }}>
                <Text style={{ margin: 10, fontSize: 15, textAlign: 'left' }}>I'm in the Drawer!</Text>
                <DrawerItem label="apple" targetTab={types.TAB_NAME_APPLE} iconName="apple" isSelected={types.TAB_NAME_APPLE === key} onPress={switchTabApple}></DrawerItem>
                <DrawerItem label="gallery" targetTab={types.TAB_NAME_GALLERY} iconName="picture-o" isSelected={types.TAB_NAME_GALLERY === key} onPress={switchTabGallery}></DrawerItem>
                <DrawerItem label="banana" targetTab={types.TAB_NAME_BANANA} iconName="music" isSelected={types.TAB_NAME_BANANA === key} onPress={switchTabBanana}></DrawerItem>
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
                <Header></Header>
                <DrawerLayoutAndroid style={{ flex: 1 }}
                    drawerWidth={300}
                    drawerPosition={DrawerLayoutAndroid.positions.Left}
                    renderNavigationView={() => insideDrawer}
                    ref={ref => this._drawer = ref}>

                    <View style={{ flex: 1 }}>

                        {
                            React.createElement(componentToRender)
                        }

                        {/** 
                        <Button onPress={forward} title="forward"></Button>
                        <Button onPress={backward} title="backward"></Button>
                        <Button onPress={() => { push(sceneProps.scene.route.key + Date.now()) } } title="push"></Button>
                        <Button onPress={() => { pop() } } title="pop"></Button>    
                         */}
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
        console.log({index});
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
