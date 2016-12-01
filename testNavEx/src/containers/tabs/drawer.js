import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { ActionCreators } from '../../actions'
import * as types from '../../actions/types';

import Icon from 'react-native-vector-icons/FontAwesome';

import {
    StyleSheet,
    Text,
    View,
    TouchableNativeFeedback,
} from 'react-native';

export class DrawerItem extends Component {
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

class Drawer extends Component {
    render() {
        const { navigation, switchTabApple, switchTabGallery, switchTabBanana, drawer_close, navigationKey } = this.props;
        
        const actionThenClose = (fn) => {
            return () => {
                fn();
                drawer_close();
            };
        }

        return (
            <View style={{ flex: 1, backgroundColor: '#fff' }}>
                <Text style={{ margin: 10, fontSize: 15, textAlign: 'left' }}>I'm in the Drawer!</Text>
                <DrawerItem label="apple" targetTab={types.TAB_NAME_APPLE} iconName="apple" isSelected={types.TAB_NAME_APPLE === navigationKey} onPress={actionThenClose(switchTabApple)}></DrawerItem>
                <DrawerItem label="gallery" targetTab={types.TAB_NAME_GALLERY} iconName="picture-o" isSelected={types.TAB_NAME_GALLERY === navigationKey} onPress={actionThenClose(switchTabGallery)}></DrawerItem>
                <DrawerItem label="banana" targetTab={types.TAB_NAME_BANANA} iconName="music" isSelected={types.TAB_NAME_BANANA === navigationKey} onPress={actionThenClose(switchTabBanana)}></DrawerItem>
            </View>
        );
    }
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators(ActionCreators, dispatch);
}

export default connect(() => ({}), mapDispatchToProps)(Drawer);


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
});
