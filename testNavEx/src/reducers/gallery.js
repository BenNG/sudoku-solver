import {
    NavigationExperimental,
} from 'react-native';

const {
    CardStack: NavigationCardStack,
    StateUtils: NavigationStateUtils,
} = NavigationExperimental;

import * as types from '../actions/types';
import Immutable from 'immutable';

function initialState() {
    return {
        multiSelection: false,
        selectedItems: [],
    };
}

export const gallery = (state = initialState(), action) => {
    const uri = action.uri;
    const {selectedItems} = state;
    let index;
    switch (action.type) {
        case types.SELECTED_ITEM:
            imState = Immutable.fromJS(state);
            return imState.set("selectedItems", [uri]).toJS();
        case types.BACKWARD:
            imState = Immutable.fromJS(state);
            return imState.set("selectedItems", []).toJS();
        default:
            return state;
    }
}; 