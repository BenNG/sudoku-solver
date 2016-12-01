import * as types from './types';

export function drawer_open() {
    return {
        type: types.DRAWER_OPEN,
    };
}
export function drawer_close() {
    return {
        type: types.DRAWER_CLOSE,
    };
}