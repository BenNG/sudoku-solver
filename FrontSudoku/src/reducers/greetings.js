import * as types from '../actions/types';
import Immutable from 'immutable';

const greetingsInitialState = {
  message: "Salut",
};
export const greetings = (state = Immutable.fromJS(greetingsInitialState), action) => {
  switch (action.type) {
    case types.NORMAL:
      return state.setIn(["message"], "Salut");
    case types.RESPECT:
      return state.setIn(["message"], "Bonjour");
    default:
      return state;
  }
};

