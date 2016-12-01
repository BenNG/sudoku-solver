import {
    Text,
    View,
    ToolbarAndroid,
    StyleSheet,
} from 'react-native';
import React, { Component } from 'react';
import Icon from 'react-native-vector-icons/FontAwesome';


export default class Header extends Component {
    constructor(props) {
        super(props);
        this.onIconClicked = this.onIconClicked.bind(this);
    }
    render() {
        const { leftIcon } = this.props;
        return (
            <ToolbarAndroid
                navIcon={require("./menu.png")}
                title={this.props.title}
                // subtitle="ezaeza"
                // subtitleColor= "rgba(0,0,0,0.4)"
                onIconClicked={leftIcon.onPress}
                style={[styles.toolbar, this.props.styles]}>
            </ToolbarAndroid>
        );
    }
    onIconClicked() {
        console.log("onIconClicked");
        this.props.openDrawerFn();
        console.log(arguments);

    }
}

var styles = StyleSheet.create({
  toolbar: {
    backgroundColor: '#e9eaed',
    height: 56,
  },
});