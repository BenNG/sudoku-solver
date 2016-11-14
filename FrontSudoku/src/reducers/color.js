import * as types from '../actions/types';
import Immutable from 'immutable';

const colorInitialState = {
  value: "black",
};
export const color = (state = Immutable.fromJS(colorInitialState), action) => {
  switch (action.type) {
    case types.BLACK:
      return state.setIn(["value"], "black");
    case types.GREEN:
      return state.setIn(["value"], "green");
    default:
      return state;
  }
};