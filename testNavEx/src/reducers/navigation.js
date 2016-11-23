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
                { key: 'apple' },
                { key: 'banana' },
                { key: 'orange' },
            ],
        },
        apple: {
            index: 0,
            routes: [
                { key: "details apple" },
            ]
        },
        banana: {
            index: 0,
            routes: [
                { key: "details banana" },
            ]
        },
        orange: {
            index: 0,
            routes: [
                { key: "details orange" },
            ]
        },
    };
}

export const navigation = (state = initialState(), action) => {
    let { type } = action;

    console.log(state);

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
        case types.SWITCH_TAB:
            tabKey = action.tabKey; // we will go there
            newState = NavigationStateUtils.jumpTo(tabsNavigationState, tabKey);
            imState = Immutable.fromJS(state);
            return imState.set("tabs", newState).toJS();
        default:
            return state;
    }
}; 