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
            // newState = NavigationStateUtils.jumpTo(tabsNavigationState, types.TAB_NAME_BANANA);

            if ((index = state.selectedItems.indexOf(uri)) === -1) {
                state.selectedItems = selectedItems.concat([uri]);
            } else {
                selectedItems.splice(index, 1);
                state.selectedItems = selectedItems.slice(); 
            }
            return Object.assign({}, state);
        default:
            return state;
    }
}; 