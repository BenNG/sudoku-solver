import React, { Component } from 'react';
import { Provider, connect } from 'react-redux';

import {
    StyleSheet,
    Text,
    View,
    Button,
} from 'react-native';

class FrontSudoku extends Component {
    render() {

        console.log("render");

        const { greetings } = this.props;
        const message = greetings.get("message");
        return (
            <View>
                <Text style={{color: this.props.color.get("value")}}>
                    {message} to React Native!
                </Text>
                <Button title="Cool" onPress={() => { this.props.dispatch({ type: "NORMAL" }); } } />
                <Button title="Respect" onPress={() => { this.props.dispatch({ type: "RESPECT" }); } } />
                <Button title="black" onPress={() => { this.props.dispatch({ type: "BLACK" }); } } />
                <Button title="green" onPress={() => { this.props.dispatch({ type: "GREEN" }); } } />
            </View>
        );
    }
}

const styles = StyleSheet.create({
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
        greetings: state.greetings,
        color: state.color,
    }
}

export default connect(mapStateToProps)(FrontSudoku);
