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
            index: 2,
            routes: [
                { key: types.TAB_NAME_APPLE },
                { key: types.TAB_NAME_BANANA },
                { key: types.TAB_NAME_GALLERY },
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
        [types.TAB_NAME_GALLERY]: {
            index: 0,
            routes: [
                // { key: "folders" }, // for now we can't list the folders, we display all the pictures in all folders
                { key: "folder" },
                { key: "picture" },
            ]
        },
    };
}

export const navigation = (state = initialState(), action) => {
    let { type } = action;
    let tabsNavigationState = state.tabs;
    let index, subIndex, maxIndex;
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
        case types.FORWARD:
            maxIndex = subNavigationState.routes.length - 1;
            subIndex = subNavigationState.index;
            if (subIndex < maxIndex) {
                newState = NavigationStateUtils.jumpToIndex(subNavigationState, subIndex + 1);
                imState = Immutable.fromJS(state);
                return imState.set(key, newState).toJS();
            } else {
                return state;
            }
        case types.BACKWARD:
            subIndex = subNavigationState.index;
            if (subIndex > 0) {
                newState = NavigationStateUtils.jumpToIndex(subNavigationState, subIndex - 1);
            }else{
                return state;
            }
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
        case types.SWITCH_TAB_GALLERY:
            newState = NavigationStateUtils.jumpTo(tabsNavigationState, types.TAB_NAME_GALLERY);
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