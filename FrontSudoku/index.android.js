import React, { Component } from 'react';
import { Provider, connect } from 'react-redux';
import { createStore, applyMiddleware, combineReducers, compose } from 'redux';
import createLogger from 'redux-logger';
import { thunkMiddleware } from 'redux-thunk';
import Immutable from 'immutable';
import FrontSudoku from './src/containers/appContainer.js';
import * as types from './src/actions/types';


import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

const greetingsInitialState = {
  message: "Salut",
};
const greetings = (state = Immutable.fromJS(greetingsInitialState), action) => {
  switch (action.type) {
    case types.NORMAL:
      return state.setIn(["message"], "Salut");
    case types.RESPECT:
      return state.setIn(["message"], "Bonjour");
    default:
      return state;
  }
};

const colorInitialState = {
  value: "black",
};
const color = (state = Immutable.fromJS(colorInitialState), action) => {
  switch (action.type) {
    case types.BLACK:
      return state.setIn(["value"], "black");
    case types.GREEN:
      return state.setIn(["value"], "green");
    default:
      return state;
  }
};

const loggerMiddleware = createLogger({predicate: (getState, action) => __DEV__});

const enhancers = compose(
  applyMiddleware(
    loggerMiddleware,
  )
);

const store = createStore(combineReducers({ greetings, color }), enhancers);

const App = () => {
  return (
    <Provider store={store}>
      <FrontSudoku />
    </Provider>
  );
};

AppRegistry.registerComponent('FrontSudoku', () => App);
