import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { Provider, connect } from 'react-redux';
import { ActionCreators } from '../actions'
import * as types from '../actions/types';
import MenuItem from './menuItem';

import {
    StyleSheet,
    Text,
    View,
    Button,
    DrawerLayoutAndroid,
    TouchableHighlight,
} from 'react-native';

class TabView extends Component {
    constructor(props) {
        super(props);
        this.renderNavigationView = this.renderNavigationView.bind(this);
        this.onTabSelect = this.onTabSelect.bind(this);
    }

    onTabSelect(tab) {
        if (this.props.tab !== tab) {
            this.props.onTabSelect(tab);
        }
        this.refs.drawer.closeDrawer();
    }

    renderNavigationView() {
        let tab = this.props.navigation.get("tab");
        return (
            <View>
                <MenuItem
                    title="Home"
                    icon={require('./img/home-outline.png')}
                    selectedIcon={require('./img/home-outline.png')}
                    selected={tab === 'home'}
                    onPress={this.props.goToHome} />
                <MenuItem
                    title="Your Sudokus"
                    icon={require('./img/grid.png')}
                    selectedIcon={require('./img/grid.png')}
                    selected={tab === 'sudoku'}
                    onPress={this.props.goToSudoku} />
            </View>
        );
    }

    render() {

        return (
            <DrawerLayoutAndroid
                renderNavigationView={this.renderNavigationView}
                drawerWidth={300}
                drawerPosition={DrawerLayoutAndroid.positions.Left}>
                <Text>Blaaaaaaaaaaaaaaaaaaaaaaaaaaa ! {this.props.navigation.get("tab")}</Text>
            </DrawerLayoutAndroid>
        );
    }
}

const styles = StyleSheet.create({
    drawer: {
        flex: 1,
        backgroundColor: 'white',
    },
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

function mapStateToProps(state) {
    return {
        navigation: state.navigation,
    }
}


function mapDispatchToProps(dispatch) {
    return bindActionCreators(ActionCreators, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(TabView);