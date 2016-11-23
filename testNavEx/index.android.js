import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';
import { Provider, connect } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import { thunkMiddleware } from 'redux-thunk';
import reducers from './src/reducers';
import enhancers from './src/middlewares';
import AppContainer from './src/containers/appContainer.js';

const store = createStore(reducers, enhancers);

const App = () => {
  return (
    <Provider store={store}>
      <AppContainer />
    </Provider>
  );
};


AppRegistry.registerComponent('testNavEx', () => App);