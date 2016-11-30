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
            <ToolbarAndroid
                navIcon={require("./menu.png")}
                logo={require("./emoticon.png")}
                title="Toolbar"
                actions={[{ title: 'Settings', icon: require('./settings.png'), show: 'always' }]}
                onActionSelected={this.onActionSelected}
                onIconClicked={this.onIconClicked}>
                <View>
                    <Text>HHHHHHHHH</Text>
                    <Text>HHHHHHHHH</Text>
                    <Text>HHHHHHHHH</Text>
                </View>
            </ToolbarAndroid>
        );
    }
    onActionSelected(position) {
        console.log(position);
    }
    onIconClicked() {
        console.log("onIconClicked");
        console.log(arguments);

    }
}