import * as types from '../actions/types';
import Immutable from 'immutable';

const navigationInitialState = {
  tab: "home",
};
export const navigation = (state = Immutable.fromJS(navigationInitialState), action) => {
  switch (action.type) {
    case types.SWITCH_TAB_TO_HOME:
      return state.setIn(["tab"], "home");
    case types.SWITCH_TAB_TO_SUDOKU:
      return state.setIn(["tab"], "sudoku");
    default:
      return state;
  }
};