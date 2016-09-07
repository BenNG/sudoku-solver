/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  TouchableHighlight,
  View,
  NavigationExperimental,
  ScrollView,
} from 'react-native';

import {Home} from './js/views/home'
import {Camera} from './js/views/camera'
import {Validation} from './js/views/validation'
import {Result} from './js/views/result'

const {
 CardStack: NavigationCardStack,
 StateUtils: NavigationStateUtils
} = NavigationExperimental

class front extends Component {

  constructor(props){
    super(props);
    this.state = {
      navState: NavReducer(undefined, {})
    }

    this._handleAction = this._handleAction.bind(this);
    this._renderScene = this._renderScene.bind(this);
    this.handleBackAction = this.handleBackAction.bind(this);
  }

  _renderRoute (key) {
    if (key.startsWith('Home')) {
      return <Home
               onPress={this._handleAction.bind(this,
               { type: 'push', key: 'Camera' + Date.now() })} />
    }
    if (key.startsWith('Camera')) {
      return <Camera
              goBack={this.handleBackAction}
              onPress={this._handleAction.bind(this,
              { type: 'push', key: 'Validation' + Date.now() })} />
    }
    if (key.startsWith('Validation')) {
      return <Validation
              goBack= {this.handleBackAction}
              onPress={this._handleAction.bind(this,
              { type: 'push', key: 'Result' + Date.now() })} />
    }
    if (key.startsWith('Result')) {
      return <Result
              goBack={this.handleBackAction}
              onPress={this._handleAction.bind(this,
              { type: 'push', key: 'Camera' + Date.now() })} />
    }
  }
  _renderScene(props) {
      const ComponentToRender = this._renderRoute(props.scene.route.key)
      return (
        <ScrollView style={styles.scrollView}>
          {ComponentToRender}
        </ScrollView>
      );
  }


  _handleAction (action) {
    const newState = NavReducer(this.state.navState, action);
    if (newState === this.state.navState) {
      return false;
    }
    this.setState({
      navState: newState
    })
    return true;
  }

  handleBackAction() {
    return this._handleAction({ type: 'pop' });
  }



  render() {
    return (
      <NavigationCardStack
        navigationState={this.state.navState}
        onNavigate={this._handleAction}
        renderScene={this._renderScene} />
    )
  }
}

function createReducer(initialState) {
  return (currentState = initialState, action) => {
    switch (action.type) {
      case 'push':
        return NavigationStateUtils.push(currentState, {key: action.key});
      case 'pop':
        return currentState.index > 0 ? NavigationStateUtils.pop(currentState) : currentState;
      default:
        return currentState;
    }
  }
}

const NavReducer = createReducer({
  index: 0,
  key: "App",
  routes: [{key: "Home"}]
})

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
  button: {
    height: 70,
    marginTop: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 20,
    marginRight: 20,
    backgroundColor: '#EDEDED',
  },
});

AppRegistry.registerComponent('front', () => front);
