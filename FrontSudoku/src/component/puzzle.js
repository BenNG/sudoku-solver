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

class Puzzle extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text>
                    Puzzle
                </Text>
                <Button title="go to selected" onPress={ () => { this.props.navigate({key: "SelectedPuzzle", id: 345}) } } />
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
});

export default Puzzle;