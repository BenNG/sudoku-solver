import {
    Text,
    View,
    Image,
} from 'react-native';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';
import { ActionCreators } from '../../actions'

import React, { Component } from 'react';

class Picture extends Component {
    render() {
        return (
            <View style={{flex:1}}>
                <Image source={{ uri: this.props.gallery.selectedItems[0] }} style={{ flex:1 }}></Image>
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
