import {
    Text,
    View,
    Image,
    StyleSheet,
} from 'react-native';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { ActionCreators } from '../../actions'

import React, { Component } from 'react';

class Picture extends Component {

    render() {
        console.log(this.props.gallery.selectedItems[0]);
        return (
            <View style={styles.imageContainer}>
                <Image style={styles.image} source={{ uri: this.props.gallery.selectedItems[0] }}></Image>
            </View>
        );
    }
}

function mapStateToProps(state) {
    return {
        gallery: state.gallery,
    };
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators(ActionCreators, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Picture);

var styles = StyleSheet.create({
    imageContainer: {
        flex: 1,
        justifyContent: "flex-start",
        flexDirection: "column",
    },
    image: {
        flex:1,
    }
});