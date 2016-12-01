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
        console.log(this.props)
        return (
            <ToolbarAndroid
                navIcon={require("./menu.png")}
                logo={require("./emoticon.png")}
                title="Toolbar"
                onIconClicked={this.onIconClicked}
                style={[styles.toolbar, this.props.styles]}>
            </ToolbarAndroid>
        );
    }
    onActionSelected(position) {
        console.log("onActionSelected");
        console.log(position);
    }
    onIconClicked() {
        console.log("onIconClicked");
        this.props.openDrawerFn();
        console.log(arguments);

    }
}


const styles = StyleSheet.create({
    toolbar: {
        height: 50,
    },
});
