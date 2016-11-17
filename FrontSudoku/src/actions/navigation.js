import * as types from './types';

export function switchTab(tab) {
    return {
        type: types.SWITCH_TAB,
        tab,
    };
}

export function navigate(action) {
    return navigateForward(action);
}

function navigateForward(state) {
    return {
        type: types.NAVIGATION_FORWARD,
        state,
    };
}

export function navigateBack() {
    return (dispatch, getState) => {
        dispatch({
            type: types.NAVIGATION_BACK,
        });
    };
}