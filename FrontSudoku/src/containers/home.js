import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { Provider, connect } from 'react-redux';
import { ActionCreators } from '../actions'
import * as types from '../actions/types';

import {
    StyleSheet,
    Text,
    View,
    Button,
} from 'react-native';

class Home extends Component {
    render() {

        console.log(this.props);

        const { greetings } = this.props;
        const message = greetings.get("message");
        return (
            <View>
                <Text style={{color: this.props.color.get("value")}}>
                    {message} to React Native!
                </Text>
                <Button title="Cool" onPress={ this.props.setNormalMessage } />
                <Button title="Respect" onPress={ this.props.setRespectMessage } />
                <Button title="black" onPress={ this.props.setColorInBlack } />
                <Button title="green" onPress={ this.props.setColorInGreen } />
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


function mapDispatchToProps(dispatch) {
  return bindActionCreators(ActionCreators, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Home);