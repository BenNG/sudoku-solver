import * as types from './types';

export function switchTabApple() {
    return {
        type: types.SWITCH_TAB_APPLE,
    };
}
export function switchTabGallery() {
    return {
        type: types.SWITCH_TAB_GALLERY,
    };
}
export function switchTabBanana() {
    return {
        type: types.SWITCH_TAB_BANANA,
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