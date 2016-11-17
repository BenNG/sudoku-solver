import {
    NavigationExperimental,
} from 'react-native';
import * as types from '../actions/types';
import Immutable from 'immutable';

const {
  CardStack: NavigationCardStack,
  StateUtils: NavigationStateUtils,
} = NavigationExperimental;

const navigationInitialState = {
  tab: "home",
};
export const navigation = (state = Immutable.fromJS(navigationInitialState), action) => {
  switch (action.type) {
    case types.SWITCH_TAB:
      return state.setIn(["tab"], action.tab);
    default:
      return state;
  }
}; 

const navigationStateInitialState = {
  index: 0,
  routes: [{key: "TabView"}, {key: "SelectedPuzzle"}]
};
export const navigationState = (state = navigationStateInitialState, action) => {
  switch (action.type) {
    case types.NAVIGATION_FORWARD:
      return NavigationStateUtils.forward(state);
    case types.NAVIGATION_BACK:
      return NavigationStateUtils.back(state);
    default:
      return state;
  }
};  

export const navigationParams = (state = {}, action) => {
  switch (action.type) {
    case types.NAVIGATION_FORWARD:
      return action.state;
    default:
      return state;
  }
};  