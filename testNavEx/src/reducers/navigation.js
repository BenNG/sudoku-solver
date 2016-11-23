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
        tabs: {
            index: 0,
            routes: [
                { key: types.TAB_NAME_APPLE },
                { key: types.TAB_NAME_BANANA },
                { key: types.TAB_NAME_ORANGE },
            ],
        },
        [types.TAB_NAME_APPLE]: {
            index: 0,
            routes: [
                { key: "details apple" },
            ]
        },
        [types.TAB_NAME_BANANA]: {
            index: 0,
            routes: [
                { key: "details banana" },
            ]
        },
        [types.TAB_NAME_ORANGE]: {
            index: 0,
            routes: [
                { key: "details orange" },
            ]
        },
    };
}

export const navigation = (state = initialState(), action) => {
    let { type } = action;
    let tabsNavigationState = state.tabs;
    let index;
    let key;
    let subNavigationState;
    let newState;
    let returnObject = {}
    let imState;

    if (type !== "selectTab") {
        index = tabsNavigationState.index;
        key = tabsNavigationState.routes[index].key;
        subNavigationState = state[key];
    }

    switch (action.type) {
        case types.PUSH:
            newState = NavigationStateUtils.push(subNavigationState, action.route);
            imState = Immutable.fromJS(state);
            return imState.set(key, newState).toJS();
        case types.POP:
            newState = NavigationStateUtils.pop(subNavigationState);
            imState = Immutable.fromJS(state);
            return imState.set(key, newState).toJS();
        case types.SWITCH_TAB_APPLE:
            newState = NavigationStateUtils.jumpTo(tabsNavigationState, types.TAB_NAME_APPLE);
            imState = Immutable.fromJS(state);
            return imState.set("tabs", newState).toJS();
        case types.SWITCH_TAB_ORANGE:
            newState = NavigationStateUtils.jumpTo(tabsNavigationState, types.TAB_NAME_ORANGE);
            imState = Immutable.fromJS(state);
            return imState.set("tabs", newState).toJS();
        case types.SWITCH_TAB_BANANA:
            newState = NavigationStateUtils.jumpTo(tabsNavigationState, types.TAB_NAME_BANANA);
            imState = Immutable.fromJS(state);
            return imState.set("tabs", newState).toJS();
        default:
            return state;
    }
}; 