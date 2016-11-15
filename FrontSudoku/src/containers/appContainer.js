import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { Provider, connect } from 'react-redux';
import { ActionCreators } from '../actions'
import Home from './home';
import TabView from '../tabs/tabView';

class AppContainer extends Component {
    render() {
        return (
            <TabView {...this.props} />
        );
    }
}

function mapStateToProps(state) {
    return {
        greetings: state.greetings,
        color: state.color,
    }
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators(ActionCreators, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(AppContainer);