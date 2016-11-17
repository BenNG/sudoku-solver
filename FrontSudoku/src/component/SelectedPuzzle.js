import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { Provider, connect } from 'react-redux';
import { ActionCreators } from '../actions'
import * as types from '../actions/types';

import {
    StyleSheet,
    Text,
    View,
} from 'react-native';

class SelectedPuzzle extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text>
                    SelectedPuzzle
                </Text>
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

export default SelectedPuzzle;