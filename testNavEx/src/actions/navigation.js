import * as types from './types';

export function switchTab(tabKey) {
    return {
        type: types.SWITCH_TAB,
        tabKey,
    };
}
export function push(key) {
    return {
        type: types.PUSH,
        route: {
            key,
        }
    };
}
export function pop(key) {
    return {
        type: types.POP,
    };
}