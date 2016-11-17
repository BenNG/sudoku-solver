import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { Provider, connect } from 'react-redux';
import { ActionCreators } from '../actions'
import Home from './home';
import TabView from '../tabs/tabView';
import SelectedPuzzle from '../component/SelectedPuzzle';
import {
    StyleSheet,
    Animated,
    View,
    NavigationExperimental,
} from 'react-native';

const {
    PropTypes: NavigationPropTypes,
    StateUtils: NavigationStateUtils,
    Card: NavigationCard,
    Transitioner: NavigationTransitioner,
} = NavigationExperimental;

const {
    PagerStyleInterpolator: NavigationPagerStyleInterpolator,
} = NavigationCard;

class AppContainer extends Component {
    constructor(props) {
        super(props);
        this._render = this._render.bind(this);
    }
    render() {
        return (
            <NavigationTransitioner
                navigationState={this.props.navigationState}
                render={this._render}
                />
        );
    }

    _renderScene(sceneProps) {
        return (<SceneContainer {...sceneProps} key={sceneProps.scene.key} />);
    }

    _render(transitionProps) {
        const scenes = transitionProps.scenes.map((scene) => {
            const sceneProps = Object.assign({}, transitionProps, { scene });
            return this._renderScene(sceneProps);
        });
        return <View style={{ flex: 1 }}>
            {scenes}
        </View>
    }

}

class SceneContainer extends Component {
    render() {
        const style = [
            styles.scene,
            NavigationPagerStyleInterpolator.forHorizontal(this.props),
        ];
        let Scene = null;
        if (this.props.scene.route.key === "TabView") {
            Scene = TabView;
        }
        if (this.props.scene.route.key === "SelectedPuzzle") {
            Scene = SelectedPuzzle;
        }
        return (
            <Animated.View style={style}>
                <Scene {...this.props} style={style}  ></Scene>
            </Animated.View>
        );
    }
}

const styles = StyleSheet.create({
    scene: {
        flex: 1,
        position: 'absolute',
        bottom: 0,
        top: 0,
        left: 0,
        right: 0,
    },
});

function mapStateToProps(state) {
    return {
        greetings: state.greetings,
        color: state.color,
        navigationState: state.navigationState,
    }
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators(ActionCreators, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(AppContainer);