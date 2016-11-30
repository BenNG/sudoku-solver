import {
    Text,
    View,
    ToolbarAndroid,
} from 'react-native';
import React, { Component } from 'react';
import Icon from 'react-native-vector-icons/FontAwesome';


export default class MyNewComponent extends Component {
    render() {
        console.log(this.props)
        return (
            <Icon.ToolbarAndroid
                // actions={toolbarActions}
                navIconName="bars"
                // onActionSelected={this._onActionSelected}
                onIconClicked={this.props.onPress}
                // style={styles.toolbar}
                // subtitle={this.state.actionText}
                title="Toolbar" >
                <View>
                    <Text>HHHHHHHHH</Text>
                    <Text>HHHHHHHHH</Text>
                    <Text>HHHHHHHHH</Text>
                </View>
            </Icon.ToolbarAndroid>
        );
    }
}