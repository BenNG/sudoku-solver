import React, { Component } from 'react';
import { Provider, connect } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import { thunkMiddleware } from 'redux-thunk';
import FrontSudoku from './src/containers/appContainer.js';
import reducers from './src/reducers';
import enhancers from './src/middlewares';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

const store = createStore(reducers, enhancers);

const App = () => {
  return (
    <Provider store={store}>
      <FrontSudoku />
    </Provider>
  );
};

AppRegistry.registerComponent('FrontSudoku', () => App);
