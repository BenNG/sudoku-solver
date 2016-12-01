import {
    NavigationExperimental,
} from 'react-native';

const {
    StateUtils: NavigationStateUtils,
} = NavigationExperimental;

import * as types from '../actions/types';
import Immutable from 'immutable';

function initialState() {
    return {
        isDrawerOpen: true
    };
}

export const drawer = (state = initialState(), action) => {
    let { type } = action;

    switch (action.type) {
        case types.DRAWER_OPEN:
            imState = Immutable.fromJS(state);
            return imState.set("isDrawerOpen", true).toJS();
        case types.DRAWER_CLOSE:
            imState = Immutable.fromJS(state);
            return imState.set("isDrawerOpen", false).toJS();
        default:
            return state;
    }
}; 