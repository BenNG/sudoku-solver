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
            <View style={styles.container}>
                <View style={{flexDirection: "row", alignItems: "center"}}>
                    <Icon onPress={leftIcon.onPress} name="bars" size={20} color="#000" style={styles.leftIcon} />
                    <Text>{this.props.title}</Text>
                </View>
            </View>
        );
    }
    // render() {
    //     console.log(this.props)
    //     return (
    //         <ToolbarAndroid
    //             navIcon={require("./menu.png")}
    //             logo={require("./emoticon.png")}
    //             title="Toolbar"
    //             onIconClicked={this.onIconClicked}
    //             style={[styles.toolbar, this.props.styles]}>
    //         </ToolbarAndroid>
    //     );
    // }
    onIconClicked() {
        console.log("onIconClicked");
        this.props.openDrawerFn();
        console.log(arguments);

    }
}


const styles = StyleSheet.create({
    container: {
        flexDirection: "row",
        // justifyContent: "space-between",
        // backgroundColor: "red",
        height: 46,
    },
    leftIcon: {
        // backgroundColor: "green",
        paddingVertical: 10,
        paddingHorizontal: 15,
    },
});
