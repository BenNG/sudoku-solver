import React, { Component } from 'react';
import { Provider, connect } from 'react-redux';
import { createStore, applyMiddleware, combineReducers, compose } from 'redux';
import createLogger from 'redux-logger';
import { thunkMiddleware } from 'redux-thunk';
import Immutable from 'immutable';
import FrontSudoku from './src/home';

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
    case 'NORMAL':
      return state.setIn(["message"], "Salut");
    case 'RESPECT':
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
    case 'BLACK':
      return state.setIn(["value"], "black");
    case 'GREEN':
      return state.setIn(["value"], "green");
    default:
      return state;
  }
};

const store = createStore(combineReducers({ greetings, color }));

const App = () => {
  return (
    <Provider store={store}>
      <FrontSudoku />
    </Provider>
  );
};

AppRegistry.registerComponent('FrontSudoku', () => App);
